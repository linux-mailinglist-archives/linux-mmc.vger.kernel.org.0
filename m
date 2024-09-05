Return-Path: <linux-mmc+bounces-3747-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1AC96D5E9
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2024 12:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84912B257CF
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2024 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627119DF8C;
	Thu,  5 Sep 2024 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSK2+GWX"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CEC199956;
	Thu,  5 Sep 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531704; cv=none; b=Zgsl8lhjXBsYiTnXiopf4OcNmbOMrRosMoB7i0IrvKCpF+FSfk6R/g9XdVVKth74mUW9yTuFAH9sTtAcY1GY8KSx6P7m7TR8+s+3r6v65s1UZZJNPCOoWInebMHMHCbmRggLLVder2wIYebCaaXhabw5XgZ1k7YP2mqkFehx31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531704; c=relaxed/simple;
	bh=ReXn0AX6QqLUzy2dlXpai2FZdR82dGzC8hJwD2/eFdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p13GlaGPamWyWwg8BFLXojIVEAys/OujJgDN7ioeniVmQ1lXAcL1GrhuQefGAMZAP8k6uHZZH07yNoCD1YcGXCFcB7+Vnyu5NWrVHE5SqJcOzoFlGp7WjQdsZsfg5MXJ9YH5w49RmHjkcEmZm7CHhzc6Jrv6nksM1GJFVXR/gAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSK2+GWX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2055136b612so6562005ad.0;
        Thu, 05 Sep 2024 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531702; x=1726136502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy+nNOTiYW+UBvk1TQl3TfPHhOHgpeNxvuW/sgq/wfI=;
        b=GSK2+GWXgbOg0tPEEkreFtnq9KlYLBLtok9mpWoyPM8kqm7lofxswoOXPr7rBomVe0
         vcp6MMhV2+V/wzQa62uuHexIsBkqoAYNBaVroxNlLjbP15jA6jO3FrKen+r0T7ncB+Th
         1ZBsPYfx31F6SUVosTTBfo9LHhfq1KgwYj6jlIb1cDAEQQme/tF8ADrnpMxiObOlpp7A
         fniNzVXtHSBs7XaLwp1hMVEApIE8lKpkSqjns8wQv2KkVi7SlIrHdidhQbrfB8W82CBR
         573lv74V5tapyVa8Txjnou6wegEPyDDcErh6vbwysYEH6QTibk46IuI7Z3wEFitpp3eG
         vwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531702; x=1726136502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy+nNOTiYW+UBvk1TQl3TfPHhOHgpeNxvuW/sgq/wfI=;
        b=S7w0ycVCjPCP9f+4kPBFxJ0j89cD2BPEYevbyPxljdgIwq51X6PjokkEAqENQk1zEN
         o8qsHBh7cSQVZVFXOQO65TinIO0QZlOBCtncZknQ1q8493eDgNby87NMlb+I8ohPxzOQ
         zerXwBN3a7d64NmtsUWytPs3mPW7MppMZ1Eopqhg7oQ6EALcNgooa0JWq7IVVkE6Miel
         FYwP21JVo2DKGk7KLHDLjEnUwvQxv+Shtx2PM32Ww2w5fH6pJuNh6LvYOQ4Vadqw6A2T
         VcETwoUlPo/oOd0YmEZSbtL5FP+bOhQKY2+6lzV7SIttax8rNiKURQztsMxoo1soMDNS
         IN9g==
X-Forwarded-Encrypted: i=1; AJvYcCU0O0haKOFA0mJR6Wjq17i4SWFN8EPk+2o5cYsSBTY52u2Qut2AGyyatxueL4QoZKM9fT+bTZ8Ooxmb89w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye88mlxF9dCMyp5YK/CfFDtl4EL/oW3FJDiUMwoPEqCWISUYOJ
	SdzE4RAh5mcg8HRzD7rD3DF40TDiZf07652Jn1gcaV4Y3S46fa3Z
X-Google-Smtp-Source: AGHT+IGMLaSIB+PdxH1nfzOjbhvMJqYwAwRkyVlu5GMWPaLjEufmBU6eDFFrGXbPYtVQnJSRRkTiVA==
X-Received: by 2002:a17:902:e804:b0:202:4b65:65af with SMTP id d9443c01a7336-20546b35a4cmr214335855ad.52.1725531701689;
        Thu, 05 Sep 2024 03:21:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:21:41 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Lucas Lai <lucas.lai@genesyslogic.com.tw>
Subject: [PATCH V20 22/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
Date: Thu,  5 Sep 2024 18:20:00 +0800
Message-Id: <20240905102000.5020-23-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905102000.5020-1-victorshihgli@gmail.com>
References: <20240905102000.5020-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Changes are:
 * Enable the internal clock when do reset on UHS-II mode.
 * Increase timeout value before detecting UHS-II interface.
 * Add vendor settings for UHS-II mode.
 * Use the function sdhci_gli_wait_software_reset_done() for gl9767 reset.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
---

Updates in V20:
 - Use the function sdhci_gli_wait_software_reset_done() for gl9767 reset.

Updates in V19:
 - Use sdhci_gli_enable_internal_clock() to simplify the code
   in the sdhci_gl9767_reset().
 - Directly reading the SDHCI_PRESENT_STATE register to replace
   the get_cd() avoids the possibility of the get_cd() sleeping
   in the sdhci_gl9767_set_card_detect_debounce_time().
 - Refine the position of gli_set_9767() in the sdhci_gl9767_reset().

Updates in V18:
 - Add new register settings for gl9767.
 - Add card_event in the sdhci_ops for gl9767.
 - Add sdhci_gl9767_set_card_detect_debounce_time()
   to configure the gl9767.
 - Adjust the sdhci_gl9767_reset() process for gl9767.

Updates in V17:
 - Use mmc_card_uhs2() to simplify the code in the sdhci_gl9767_reset().
 - Use mmc_card_uhs2() to simplify the code in the
   sdhci_gl9767_set_power().
 - Add sdhci_gli_overcurrent_event_enable() to sdhci_gl9767_set_power().

Updates in V15:
 - Add gl9767 to support uhs2 function.

---

 drivers/mmc/host/sdhci-pci-gli.c | 203 ++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 7cf27a666f34..dd4bd21a6019 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -174,6 +174,15 @@
 #define PCI_GLI_9755_MISC	    0x78
 #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
 
+#define SDHCI_GLI_9767_SD_HOST_OPERATION_CTL				0x508
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_CMD_CONFLICT_CHECK	  BIT(0)
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE			  GENMASK(21, 16)
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_IN_VALUE	  0x05
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_OUT_VALUE	  0x3F
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE		  GENMASK(23, 22)
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_1MS	  0x2
+#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_10MS	  0x3
+
 #define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
 #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
 
@@ -210,6 +219,13 @@
 #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
 #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
 
+#define PCIE_GLI_9767_RESET_REG				0x8E4
+#define   PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET	  BIT(0)
+
+#define PCIE_GLI_9767_UHS2_PHY_SET_REG1				0x90C
+#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR		  GENMASK(31, 29)
+#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE	  0x3
+
 #define PCIE_GLI_9767_SDHC_CAP			0x91C
 #define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT	  BIT(5)
 
@@ -228,9 +244,15 @@
 #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE	  BIT(1)
 
 #define PCIE_GLI_9767_SD_DATA_MULTI_CTL				0x944
+#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2		  BIT(5)
+#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL	  BIT(8)
 #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME	  GENMASK(23, 16)
 #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE	  0x64
 
+#define PCIE_GLI_9767_UHS2_PHY_SET_REG2					0x948
+#define   PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING		  GENMASK(22, 21)
+#define   PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING_VALUE		  0x0
+
 #define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2			0x950
 #define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE	  BIT(0)
 
@@ -240,6 +262,28 @@
 #define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2				0x958
 #define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN	  BIT(0)
 
+#define PCIE_GLI_9767_UHS2_CTL1				0x95C
+#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS		  BIT(5)
+#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE	  0x1
+#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL		  BIT(6)
+#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE	  0x1
+#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN		  GENMASK(10, 7)
+#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE	  0x3
+#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV		  GENMASK(14, 11)
+#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE	  0xf
+#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS		  GENMASK(16, 15)
+#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE	  0x0
+#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV		  GENMASK(18, 17)
+#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE	  0x0
+#define   PCIE_GLI_9767_UHS2_CTL1_PDRST			  BIT(25)
+#define   PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE		  0x1
+
+#define PCIE_GLI_9767_UHS2_CTL2			0x964
+#define   PCIE_GLI_9767_UHS2_CTL2_ZC		  GENMASK(3, 0)
+#define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE	  0xb
+#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL	  BIT(6)
+#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE	  0x1
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -1156,6 +1200,31 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 	gl9767_vhs_read(pdev);
 }
 
+static void sdhci_gl9767_set_card_detect_debounce_time(struct sdhci_host *host)
+{
+	u32 value;
+
+	value = sdhci_readl(host, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
+	value &= ~(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE |
+		   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE);
+	if (sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)
+		value |= FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE,
+				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_IN_VALUE) |
+			 FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE,
+				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_1MS);
+	else
+		value |= FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE,
+				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_OUT_VALUE) |
+			 FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE,
+				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_10MS);
+	sdhci_writel(host, value, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
+}
+
+static void sdhci_gl9767_card_event(struct sdhci_host *host)
+{
+	sdhci_gl9767_set_card_detect_debounce_time(host);
+}
+
 static void gli_set_9767(struct sdhci_host *host)
 {
 	u32 value;
@@ -1163,6 +1232,12 @@ static void gli_set_9767(struct sdhci_host *host)
 	value = sdhci_readl(host, SDHCI_GLI_9767_GM_BURST_SIZE);
 	value &= ~SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET;
 	sdhci_writel(host, value, SDHCI_GLI_9767_GM_BURST_SIZE);
+
+	value = sdhci_readl(host, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
+	value &= ~SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_CMD_CONFLICT_CHECK;
+	sdhci_writel(host, value, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
+
+	sdhci_gl9767_set_card_detect_debounce_time(host);
 }
 
 static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
@@ -1201,7 +1276,44 @@ static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
 
 static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
 {
-	sdhci_reset(host, mask);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	/* need internal clock */
+	if (mask & SDHCI_RESET_ALL) {
+		sdhci_gli_enable_internal_clock(host);
+
+		gl9767_vhs_write(pdev);
+
+		pci_read_config_dword(pdev, PCIE_GLI_9767_RESET_REG, &value);
+		value &= ~PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET;
+		pci_write_config_dword(pdev, PCIE_GLI_9767_RESET_REG, value);
+
+		if (read_poll_timeout_atomic(pci_read_config_dword, value,
+					     !(value & PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET),
+					     1, 5, true, pdev, PCIE_GLI_9767_RESET_REG, &value)) {
+			pr_warn("%s: %s: Reset SDHC AHB and TL-AMBA failure.\n",
+				__func__, mmc_hostname(host->mmc));
+			gl9767_vhs_read(pdev);
+			return;
+		}
+		gl9767_vhs_read(pdev);
+	}
+
+	if (mmc_card_uhs2(host->mmc)) {
+		if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA)) {
+			sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+			sdhci_gli_uhs2_reset_sd_tran(host);
+			if (sdhci_gli_wait_software_reset_done(host, mask))
+				return;
+		} else {
+			sdhci_uhs2_reset(host, mask);
+		}
+	} else {
+		sdhci_reset(host, mask);
+	}
+
 	gli_set_9767(host);
 }
 
@@ -1292,6 +1404,86 @@ static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
+static void gl9767_vendor_init(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, &value);
+	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR,
+			    PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, &value);
+	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING,
+			    PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING_VALUE);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, &value);
+	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS,
+			    PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL,
+			    PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN,
+			    PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV,
+			    PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS,
+			    PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_RECV,
+			    PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_PDRST,
+			    PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
+	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC,
+			    PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC_CTL,
+			    PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
+
+	gl9767_vhs_read(pdev);
+}
+
+static void sdhci_gl9767_set_power(struct sdhci_host *host, unsigned char mode,	unsigned short vdd)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	if (mmc_card_uhs2(host->mmc)) {
+		gl9767_vhs_write(pdev);
+
+		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
+		value |= PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 |
+			 PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL;
+		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
+
+		gl9767_vhs_read(pdev);
+
+		sdhci_gli_overcurrent_event_enable(host, false);
+		sdhci_uhs2_set_power(host, mode, vdd);
+		sdhci_gli_overcurrent_event_enable(host, true);
+	} else {
+		gl9767_vhs_write(pdev);
+
+		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
+		value &= ~(PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 |
+			   PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL);
+		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
+
+		gl9767_vhs_read(pdev);
+
+		sdhci_gli_overcurrent_event_enable(host, false);
+		sdhci_set_power(host, mode, vdd);
+		sdhci_gli_overcurrent_event_enable(host, true);
+	}
+}
+
 static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
@@ -1328,6 +1520,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
 	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
 	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
 	sdhci_enable_v4_mode(host);
+	gl9767_vendor_init(host);
 
 	return 0;
 }
@@ -1831,12 +2024,20 @@ static const struct sdhci_ops sdhci_gl9767_ops = {
 	.reset			 = sdhci_gl9767_reset,
 	.set_uhs_signaling	 = sdhci_set_uhs_signaling,
 	.voltage_switch		 = sdhci_gl9767_voltage_switch,
+	.dump_uhs2_regs		 = sdhci_uhs2_dump_regs,
+	.set_timeout		 = sdhci_uhs2_set_timeout,
+	.irq			 = sdhci_uhs2_irq,
+	.set_power		 = sdhci_gl9767_set_power,
+	.uhs2_pre_detect_init	 = sdhci_gli_pre_detect_init,
+	.card_event		 = sdhci_gl9767_card_event,
 };
 
 const struct sdhci_pci_fixes sdhci_gl9767 = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
 	.probe_slot	= gli_probe_slot_gl9767,
+	.add_host	= sdhci_pci_uhs2_add_host,
+	.remove_host	= sdhci_pci_uhs2_remove_host,
 	.ops		= &sdhci_gl9767_ops,
 #ifdef CONFIG_PM_SLEEP
 	.resume		= sdhci_pci_gli_resume,
-- 
2.25.1


