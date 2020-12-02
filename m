Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C922CB56B
	for <lists+linux-mmc@lfdr.de>; Wed,  2 Dec 2020 08:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgLBHAY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 2 Dec 2020 02:00:24 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:37158 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgLBHAX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 02:00:23 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0B26x2DW1031983, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0B26x2DW1031983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 2 Dec 2020 14:59:02 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.36) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 2 Dec 2020 14:59:02 +0800
Received: from localhost (172.22.88.222) by RTEXMBS01.realtek.com.tw
 (172.21.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 2 Dec 2020
 14:59:02 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <bhelgaas@google.com>, <ricky_wu@realtek.com>,
        <vaibhavgupta40@gmail.com>, <kdlnx@doth.eu>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <lee.jones@linaro.org>, <dianders@chromium.org>,
        <linux-mmc@vger.kernel.org>, <wsa+renesas@sang-engineering.com>,
        <keitasuzuki.park@sslab.ics.keio.ac.jp>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] misc: rtsx: rts5249 support runtime PM
Date:   Wed, 2 Dec 2020 14:58:57 +0800
Message-ID: <20201202065857.19412-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXH365.realtek.com.tw (172.21.6.37) To
 RTEXMBS01.realtek.com.tw (172.21.6.36)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

rtsx_pcr:
add callback functions to support runtime PM
add delay_work to put device to D3 after idle
over 10 sec

rts5249:
add extra init flow for rtd3 and set rtd3_en from
config setting

rtsx_pci_sdmmc:
child device support autosuspend

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rts5249.c  |  26 +++++--
 drivers/misc/cardreader/rtsx_pcr.c | 106 ++++++++++++++++++++++++++++-
 drivers/misc/cardreader/rtsx_pcr.h |   1 +
 drivers/mmc/host/rtsx_pci_sdmmc.c  |  16 +++++
 include/linux/rtsx_pci.h           |   2 +
 5 files changed, 145 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index b85279f1fc5e..b2676e7f5027 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -73,6 +73,9 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 
 	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
+
+	pcr->rtd3_en = rtsx_reg_to_rtd3_uhsii(reg);
+
 	if (rtsx_check_mmc_support(reg))
 		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
 	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
@@ -278,15 +281,28 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
 
 	rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
 
-	if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
+	if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
 		rtsx_pci_write_register(pcr, REG_VREF, PWD_SUSPND_EN, PWD_SUSPND_EN);
-		rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x00);
-		rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x20);
+
+	if (pcr->rtd3_en) {
+		if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
+			rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x01);
+			rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x30);
+		} else {
+			rtsx_pci_write_register(pcr, PM_CTRL3, 0x01, 0x01);
+			rtsx_pci_write_register(pcr, PME_FORCE_CTL, 0xFF, 0x33);
+		}
 	} else {
-		rtsx_pci_write_register(pcr, PME_FORCE_CTL, 0xFF, 0x30);
-		rtsx_pci_write_register(pcr, PM_CTRL3, 0x01, 0x00);
+		if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
+			rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x00);
+			rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x20);
+		} else {
+			rtsx_pci_write_register(pcr, PME_FORCE_CTL, 0xFF, 0x30);
+			rtsx_pci_write_register(pcr, PM_CTRL3, 0x01, 0x00);
+		}
 	}
 
+
 	/*
 	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
 	 * to drive low, and we forcibly request clock.
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 3612063cab09..2700d1997750 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -20,6 +20,8 @@
 #include <linux/rtsx_pci.h>
 #include <linux/mmc/card.h>
 #include <asm/unaligned.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 
 #include "rtsx_pcr.h"
 #include "rts5261.h"
@@ -150,6 +152,12 @@ void rtsx_pci_start_run(struct rtsx_pcr *pcr)
 	if (pcr->remove_pci)
 		return;
 
+	if (pcr->rtd3_en)
+		if (pcr->is_runtime_suspended) {
+			pm_runtime_get(&(pcr->pci->dev));
+			pcr->is_runtime_suspended = false;
+		}
+
 	if (pcr->state != PDEV_STAT_RUN) {
 		pcr->state = PDEV_STAT_RUN;
 		if (pcr->ops->enable_auto_blink)
@@ -1081,6 +1089,16 @@ static void rtsx_pm_power_saving(struct rtsx_pcr *pcr)
 	rtsx_comm_pm_power_saving(pcr);
 }
 
+static void rtsx_pci_rtd3_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct rtsx_pcr *pcr = container_of(dwork, struct rtsx_pcr, rtd3_work);
+
+	pcr_dbg(pcr, "--> %s\n", __func__);
+	if (!pcr->is_runtime_suspended)
+		pm_runtime_put(&(pcr->pci->dev));
+}
+
 static void rtsx_pci_idle_work(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -1100,6 +1118,9 @@ static void rtsx_pci_idle_work(struct work_struct *work)
 	rtsx_pm_power_saving(pcr);
 
 	mutex_unlock(&pcr->pcr_mutex);
+
+	if (pcr->rtd3_en)
+		mod_delayed_work(system_wq, &pcr->rtd3_work, msecs_to_jiffies(10000));
 }
 
 static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
@@ -1579,6 +1600,15 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 		rtsx_pcr_cells[i].platform_data = handle;
 		rtsx_pcr_cells[i].pdata_size = sizeof(*handle);
 	}
+
+	if (pcr->rtd3_en) {
+		INIT_DELAYED_WORK(&pcr->rtd3_work, rtsx_pci_rtd3_work);
+		pm_runtime_allow(&pcidev->dev);
+		pm_runtime_enable(&pcidev->dev);
+		pcr->is_runtime_suspended = false;
+	}
+
+
 	ret = mfd_add_devices(&pcidev->dev, pcr->id, rtsx_pcr_cells,
 			ARRAY_SIZE(rtsx_pcr_cells), NULL, 0, NULL);
 	if (ret < 0)
@@ -1616,6 +1646,9 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
 	struct pcr_handle *handle = pci_get_drvdata(pcidev);
 	struct rtsx_pcr *pcr = handle->pcr;
 
+	if (pcr->rtd3_en)
+		pm_runtime_get_noresume(&pcr->pci->dev);
+
 	pcr->remove_pci = true;
 
 	/* Disable interrupts at the pcr level */
@@ -1626,6 +1659,8 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
 
 	cancel_delayed_work_sync(&pcr->carddet_work);
 	cancel_delayed_work_sync(&pcr->idle_work);
+	if (pcr->rtd3_en)
+		cancel_delayed_work_sync(&pcr->rtd3_work);
 
 	mfd_remove_devices(&pcidev->dev);
 
@@ -1643,6 +1678,11 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
 	idr_remove(&rtsx_pci_idr, pcr->id);
 	spin_unlock(&rtsx_pci_lock);
 
+	if (pcr->rtd3_en) {
+		pm_runtime_disable(&pcr->pci->dev);
+		pm_runtime_put_noidle(&pcr->pci->dev);
+	}
+
 	kfree(pcr->slots);
 	kfree(pcr);
 	kfree(handle);
@@ -1724,13 +1764,77 @@ static void rtsx_pci_shutdown(struct pci_dev *pcidev)
 		pci_disable_msi(pcr->pci);
 }
 
+static int rtsx_pci_runtime_suspend(struct device *device)
+{
+	struct pci_dev *pcidev = to_pci_dev(device);
+	struct pcr_handle *handle;
+	struct rtsx_pcr *pcr;
+
+	handle = pci_get_drvdata(pcidev);
+	pcr = handle->pcr;
+	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
+
+	cancel_delayed_work(&pcr->carddet_work);
+	cancel_delayed_work(&pcr->rtd3_work);
+	cancel_delayed_work(&pcr->idle_work);
+
+	mutex_lock(&pcr->pcr_mutex);
+	rtsx_pci_power_off(pcr, HOST_ENTER_S3);
+
+	free_irq(pcr->irq, (void *)pcr);
+
+	mutex_unlock(&pcr->pcr_mutex);
+
+	pcr->is_runtime_suspended = true;
+
+	return 0;
+}
+
+static int rtsx_pci_runtime_resume(struct device *device)
+{
+	struct pci_dev *pcidev = to_pci_dev(device);
+	struct pcr_handle *handle;
+	struct rtsx_pcr *pcr;
+	int ret = 0;
+
+	handle = pci_get_drvdata(pcidev);
+	pcr = handle->pcr;
+	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
+
+	mutex_lock(&pcr->pcr_mutex);
+
+	rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
+	rtsx_pci_acquire_irq(pcr);
+	synchronize_irq(pcr->irq);
+
+	if (pcr->ops->fetch_vendor_settings)
+		pcr->ops->fetch_vendor_settings(pcr);
+
+	rtsx_pci_init_hw(pcr);
+
+	if (pcr->slots[RTSX_SD_CARD].p_dev != NULL) {
+		pcr->slots[RTSX_SD_CARD].card_event(
+				pcr->slots[RTSX_SD_CARD].p_dev);
+	}
+
+	schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
+
+	mutex_unlock(&pcr->pcr_mutex);
+	return ret;
+}
+
 #else /* CONFIG_PM */
 
 #define rtsx_pci_shutdown NULL
+#define rtsx_pci_runtime_suspend NULL
+#define rtsx_pic_runtime_resume NULL
 
 #endif /* CONFIG_PM */
 
-static SIMPLE_DEV_PM_OPS(rtsx_pci_pm_ops, rtsx_pci_suspend, rtsx_pci_resume);
+static const struct dev_pm_ops rtsx_pci_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(rtsx_pci_suspend, rtsx_pci_resume)
+	SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend, rtsx_pci_runtime_resume, NULL)
+};
 
 static struct pci_driver rtsx_pci_driver = {
 	.name = DRV_NAME_RTSX_PCI,
diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
index fe5f4ca0f937..daf057c4eea6 100644
--- a/drivers/misc/cardreader/rtsx_pcr.h
+++ b/drivers/misc/cardreader/rtsx_pcr.h
@@ -90,6 +90,7 @@ static inline u8 map_sd_drive(int idx)
 
 #define rtsx_check_mmc_support(reg)		((reg) & 0x10)
 #define rtsx_reg_to_rtd3(reg)				((reg) & 0x02)
+#define rtsx_reg_to_rtd3_uhsii(reg)				((reg) & 0x04)
 #define rtsx_reg_to_aspm(reg)			(((reg) >> 28) & 0x03)
 #define rtsx_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 26) & 0x03)
 #define rtsx_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 5) & 0x03)
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 93be9fa97098..94cdd3b322b5 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -20,6 +20,7 @@
 #include <linux/mmc/card.h>
 #include <linux/rtsx_pci.h>
 #include <asm/unaligned.h>
+#include <linux/pm_runtime.h>
 
 struct realtek_pci_sdmmc {
 	struct platform_device	*pdev;
@@ -1343,6 +1344,7 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
 static void realtek_init_host(struct realtek_pci_sdmmc *host)
 {
 	struct mmc_host *mmc = host->mmc;
+	struct rtsx_pcr *pcr = host->pcr;
 
 	mmc->f_min = 250000;
 	mmc->f_max = 208000000;
@@ -1350,6 +1352,8 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
 		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
+	if (pcr->rtd3_en)
+		mmc->caps = mmc->caps | MMC_CAP_AGGRESSIVE_PM;
 	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE;
 	mmc->max_current_330 = 400;
 	mmc->max_current_180 = 800;
@@ -1407,6 +1411,13 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 
 	realtek_init_host(host);
 
+	if (pcr->rtd3_en) {
+		pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
+
+
 	mmc_add_host(mmc);
 
 	return 0;
@@ -1426,6 +1437,11 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	pcr->slots[RTSX_SD_CARD].card_event = NULL;
 	mmc = host->mmc;
 
+	if (pcr->rtd3_en) {
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+
 	cancel_work_sync(&host->work);
 
 	mutex_lock(&host->host_mutex);
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 745f5e73f99a..f895ccabbe29 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1174,6 +1174,7 @@ struct rtsx_pcr {
 
 	struct delayed_work		carddet_work;
 	struct delayed_work		idle_work;
+	struct delayed_work		rtd3_work;
 
 	spinlock_t			lock;
 	struct mutex			pcr_mutex;
@@ -1183,6 +1184,7 @@ struct rtsx_pcr {
 	unsigned int			cur_clock;
 	bool				remove_pci;
 	bool				msi_en;
+	bool				is_runtime_suspended;
 
 #define EXTRA_CAPS_SD_SDR50		(1 << 0)
 #define EXTRA_CAPS_SD_SDR104		(1 << 1)
-- 
2.17.1

