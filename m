Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32593A960D
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Jun 2021 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhFPJ2a (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Jun 2021 05:28:30 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:24816 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhFPJ23 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jun 2021 05:28:29 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 Jun 2021 02:26:23 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Jun 2021 02:26:20 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 Jun 2021 14:55:38 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 1B6244CFC; Wed, 16 Jun 2021 14:55:37 +0530 (IST)
From:   Shaik Sajida Bhanu <sbhanu@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        vbadigan@codeaurora.org, rampraka@codeaurora.org,
        sayalil@codeaurora.org, sartgarg@codeaurora.org,
        rnayak@codeaurora.org, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Subject: [PATCH V1] mmc: sdhci: Update the software timeout value for sdhc
Date:   Wed, 16 Jun 2021 14:55:35 +0530
Message-Id: <1623835535-30871-1-git-send-email-sbhanu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Whenever SDHC run at clock rate 50MHZ or below, the hardware data
timeout value will be 21.47secs, which is approx. 22secs and we have
a current software timeout value as 10secs. We have to set software
timeout value more than the hardware data timeout value to avioid seeing
the below register dumps.

[  332.953670] mmc2: Timeout waiting for hardware interrupt.
[  332.959608] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
[  332.966450] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00007202
[  332.973256] mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
[  332.980054] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000027
[  332.986864] mmc2: sdhci: Present:   0x01f801f6 | Host ctl: 0x0000001f
[  332.993671] mmc2: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
[  333.000583] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
[  333.007386] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
[  333.014182] mmc2: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
[  333.020976] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  333.027771] mmc2: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x0000808f
[  333.034561] mmc2: sdhci: Cmd:       0x0000183a | Max curr: 0x00000000
[  333.041359] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
[  333.048157] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[  333.054945] mmc2: sdhci: Host ctl2: 0x00000000
[  333.059657] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
0x0000000ffffff218
[  333.067178] mmc2: sdhci_msm: ----------- VENDOR REGISTER DUMP
-----------
[  333.074343] mmc2: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
0x6000642c | DLL cfg2: 0x0020a000
[  333.083417] mmc2: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
0x00000000 | DDR cfg: 0x80040873
[  333.092850] mmc2: sdhci_msm: Vndr func: 0x00008a9c | Vndr func2 :
0xf88218a8 Vndr func3: 0x02626040
[  333.102371] mmc2: sdhci: ============================================

So, set software timeout value more than hardware timeout value.

Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bf238ad..1386f7d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1670,7 +1670,14 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	else if (!cmd->data && cmd->busy_timeout > 9000)
 		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
 	else
-		timeout += 10 * HZ;
+	       /*
+		* In some of the conditions hardware data timeout value could be
+		* approx 21.5 seconds and driver is setting software data timeout
+		* value less than the hardware data timeout value and software data
+		* timeout value should be more than the hardware data timeout value.
+		* So, set software data timeout value more than 21.5 sec i.e. 22sec.
+		*/
+		timeout += 22 * HZ;
 	sdhci_mod_timer(host, cmd->mrq, timeout);
 
 	if (host->use_external_dma)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

