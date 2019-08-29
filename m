Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD194A169F
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 12:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfH2KuJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 06:50:09 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:17271 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfH2KuJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 06:50:09 -0400
X-Greylist: delayed 84862 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 06:50:08 EDT
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x7TAnTog013730;
        Thu, 29 Aug 2019 19:49:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x7TAnTog013730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567075772;
        bh=mN61Fbu00XTQIXCA2V1aTp6gNwYlWshj6x9afbCTh5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TidcLSDRKzOZkpVzOluSTBv43i57lTHVfDqOFA489hXt/kuWoCqcLidLjb/E9E81e
         sUGEb9yFmWosleb2DfiSz+xxg1S3Ui33G3YcqDa7YgH2/Dp3FdxfCd4cn5704BPOMK
         qixixQSItz0KKtDyPKWUzgQ70Cu9q/V7zOHMBd+FLllBc8plMnL3N8Qiq9UnpB8OgB
         uWL5V2iGrODcG06Mh5+y/FC2zBSngvKGinmlFrmMkKJDWLfoZiSMQrmNbcDY4H4V6j
         57Evyga/0JSItxsH6E3JTriBJ+Oz1TbnVh8xZK4B+HmRnwhMUt0xSrFTSnPWOZ8c0o
         /ru1uFXAqb/ag==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Piotr Sroka <piotrs@cadence.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: sdhci: constify references of parameters to __sdhci_read_caps()
Date:   Thu, 29 Aug 2019 19:49:27 +0900
Message-Id: <20190829104928.27404-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190829104928.27404-1-yamada.masahiro@socionext.com>
References: <20190829104928.27404-1-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

__sdhci_read_caps() does not modify *ver, *caps, or *caps1.

Probably, the caller of this function will want to constifythe
parameters passed in.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a5dc5aae973e..08cc0792c174 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3565,7 +3565,8 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 	return ret;
 }
 
-void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
+void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
+		       const u32 *caps, const u32 *caps1)
 {
 	u16 v;
 	u64 dt_caps_mask = 0;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 902f855efe8f..81e23784475a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -738,8 +738,8 @@ static inline void *sdhci_priv(struct sdhci_host *host)
 }
 
 void sdhci_card_detect(struct sdhci_host *host);
-void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps,
-		       u32 *caps1);
+void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
+		       const u32 *caps, const u32 *caps1);
 int sdhci_setup_host(struct sdhci_host *host);
 void sdhci_cleanup_host(struct sdhci_host *host);
 int __sdhci_add_host(struct sdhci_host *host);
-- 
2.17.1

