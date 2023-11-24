Return-Path: <linux-mmc+bounces-199-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DB37F76F2
	for <lists+linux-mmc@lfdr.de>; Fri, 24 Nov 2023 15:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529471C21217
	for <lists+linux-mmc@lfdr.de>; Fri, 24 Nov 2023 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B032D781;
	Fri, 24 Nov 2023 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-mmc@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EB219A4
	for <linux-mmc@vger.kernel.org>; Fri, 24 Nov 2023 06:53:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1r6XYp-0006o6-QO; Fri, 24 Nov 2023 15:53:39 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1r6XYp-00BI0w-3G; Fri, 24 Nov 2023 15:53:39 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1r6XYo-00D3lZ-35;
	Fri, 24 Nov 2023 15:53:38 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v1 1/3] driver core: move core part of device_shutdown() to a separate function
Date: Fri, 24 Nov 2023 15:53:36 +0100
Message-Id: <20231124145338.3112416-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231124145338.3112416-1-o.rempel@pengutronix.de>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Split the device_shutdown() as a preparation for the prioritization
support.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/base/core.c | 110 +++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 47 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67ba592afc77..0f5646a097d3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4719,12 +4719,73 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+/**
+ * device_shutdown_one - shut down a device
+ * @dev: device to shut down
+ *
+ * It is called with the device lock held.
+ *
+ * The device must be on the devices_kset list.
+ */
+static void device_shutdown_one_locked(struct device *dev)
+{
+	struct device *parent;
+
+	lockdep_assert_held(&devices_kset->list_lock);
+	/*
+	 * hold reference count of device's parent to
+	 * prevent it from being freed because parent's
+	 * lock is to be held
+	 */
+	parent = get_device(dev->parent);
+	get_device(dev);
+	/*
+	 * Make sure the device is off the kset list, in the
+	 * event that dev->*->shutdown() doesn't remove it.
+	 */
+	list_del_init(&dev->kobj.entry);
+	spin_unlock(&devices_kset->list_lock);
+
+	/* hold lock to avoid race with probe/release */
+	if (parent)
+		device_lock(parent);
+	device_lock(dev);
+
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	device_unlock(dev);
+	if (parent)
+		device_unlock(parent);
+
+	put_device(dev);
+	put_device(parent);
+
+	spin_lock(&devices_kset->list_lock);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	struct device *dev;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4741,52 +4802,7 @@ void device_shutdown(void)
 		dev = list_entry(devices_kset->list.prev, struct device,
 				kobj.entry);
 
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		parent = get_device(dev->parent);
-		get_device(dev);
-		/*
-		 * Make sure the device is off the kset list, in the
-		 * event that dev->*->shutdown() doesn't remove it.
-		 */
-		list_del_init(&dev->kobj.entry);
-		spin_unlock(&devices_kset->list_lock);
-
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
-
-		spin_lock(&devices_kset->list_lock);
+		device_shutdown_one_locked(dev);
 	}
 	spin_unlock(&devices_kset->list_lock);
 }
-- 
2.39.2


