Return-Path: <linux-mmc+bounces-1506-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E888612A
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Mar 2024 20:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E28D1F22E4F
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Mar 2024 19:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7489134733;
	Thu, 21 Mar 2024 19:36:08 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A6B134720;
	Thu, 21 Mar 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049768; cv=none; b=VHdSxcDKUM8QfpiWR1+EJgYoOhYMaLBn6UcTlLrCnpzZATe/lT7ZHhNeXOFr4oOX3CeNYZ+NH+m7b524Xc7M4M8ndQamjbr/KquHjDEI+Z9wsfxAXkJT7iDkaJSVrd7s0m69IBXkpr34O/AuM8sdLHhWJnXdfz7/cSGsDwZ1zzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049768; c=relaxed/simple;
	bh=+WqGCWepyys8XN9kGbVvy3zBzdke5WnUfuDS6v5KvYo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3qq07u+KpC7uGj71TvbXuq0wK6TSxTTDAU1dhyYwNbAUjwsrTcKLglPSWfnhZMQ7ni06Pd3+52/Rr5/gDEz3eWV4cHZYL4va/+C0i9A+vEx+rdkJR5cke9LtfwIfZ32AeURmAt1Xqeh2W+XkDdJvFh4vMOfA/VueQ69K6NUugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnOCZ-0000KR-1x;
	Thu, 21 Mar 2024 19:35:47 +0000
Date: Thu, 21 Mar 2024 19:35:43 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 7/8] mmc: block: set fwnode of disk devices
Message-ID: <f3f08b1037c9e0e06598e093bb53d5e743aabfb5.1711048433.git.daniel@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711048433.git.daniel@makrotopia.org>

Set fwnode of disk devices to 'block', 'boot0' and 'boot1' subnodes of
the mmc-card. This is done in preparation for having the eMMC act as
NVMEM provider.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mmc/core/block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 64a3492e8002f..5b7dfd4a21fa5 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2463,6 +2463,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      int area_type,
 					      unsigned int part_type)
 {
+	struct fwnode_handle *fwnode;
 	struct mmc_blk_data *md;
 	int devidx, ret;
 	char cap_str[10];
@@ -2559,6 +2560,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
 
+	fwnode = device_get_named_child_node(subname ? md->parent->parent :
+						       md->parent,
+					     subname ? subname : "block");
+	if (fwnode)
+		device_set_node(disk_to_dev(md->disk), fwnode);
+
 	string_get_size((u64)size, 512, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
 	pr_info("%s: %s %s %s%s\n",
-- 
2.44.0

