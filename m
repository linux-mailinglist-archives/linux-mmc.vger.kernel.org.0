Return-Path: <linux-mmc+bounces-284-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4067FDC2D
	for <lists+linux-mmc@lfdr.de>; Wed, 29 Nov 2023 17:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A712B20DFB
	for <lists+linux-mmc@lfdr.de>; Wed, 29 Nov 2023 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277F93986F;
	Wed, 29 Nov 2023 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="LNnmJacr"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2772BF
	for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2023 08:05:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-332ed1bd4cbso3255536f8f.2
        for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2023 08:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701273937; x=1701878737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjbb5/bKLrKR7uU6/lkUOPlzDSA/y9+qdnnu1gdR+Mo=;
        b=LNnmJacr1JVy/Ys/2qY7+SJrZnnZxWeJSnNi6D7jT9ldjW7UeHAwTsMMX5yquziJTS
         mcQEUv3g4d3Kf4yj7YndfrNN03CV6gfAug2E22IE+J/JTzW8FJFmEuXG3NvtOZhqYTVk
         DOBVJTAVr3rzSBJk/YmFt0d7IWHsi17bTDRnsJhnXVwvMNzOosQHzPDxwAeSegM0sanQ
         w12Gai+QUYrUNp8XQ1Z0+tSdZP0e6cKldOtgUve6iW6BmEb+ggtq0MZH/vohzU0hbY81
         dKPz3d6ZQ8obNDEAurl/XrT28iaAlruXSLqnCorrvq2koaNpK4bnieXOA6FT4qDSCGDv
         vQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701273937; x=1701878737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjbb5/bKLrKR7uU6/lkUOPlzDSA/y9+qdnnu1gdR+Mo=;
        b=aKN5mXwovIaaGUTNqtRFi7bpp1GyW+77LfZX+igv6IchjiV+k3jMBxv6NPAGphcB7c
         7YUcLZvxsD1+VWqe4TuydoQvn36iFve9+x81EhVoJR/8yksvvYdu01/jkQwcRtueBLoU
         0pf7FFA7aTV9ghrxlV52BFjvMcppz9RcRvWi5OW8K7hn+mOfCyPtNW1kQcyX+qNTEzvI
         RrXTRzYEZ4hKQgaPAs9iJPOmYZt6+qo6J1/88ZDPtHbgJvMN6edJIli4mZvIS8Y+7cYm
         Hgz5T/3O2G9bD4zF1clpPYZDxzCpONusBOP7xCUWfMtw+MpWPZuegnuy4w2ekPoZvaKF
         1/tg==
X-Gm-Message-State: AOJu0YzJnwMce7YfCYPgfAdfstaWwwjlmd2rDx4nu/NPNAYCMFDvxKb4
	sV+yVHEbJlI9QbWX2FJuHA7nIQ==
X-Google-Smtp-Source: AGHT+IFosZdcbdyxy91uYNW1m6I3I/HQcdOTk8j4c6eugrPXB9HjcUHBz5j65WsKDwe9f2XtXOTYjA==
X-Received: by 2002:adf:f88c:0:b0:32d:ad4a:bced with SMTP id u12-20020adff88c000000b0032dad4abcedmr14191713wrp.23.1701273937093;
        Wed, 29 Nov 2023 08:05:37 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeccb000000b00332c6c5ce82sm18361744wro.94.2023.11.29.08.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:05:36 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	ulf.hansson@linaro.org,
	CLoehle@hyperstone.com,
	adrian.hunter@intel.com
Cc: jinpu.wang@ionos.com,
	hare@suse.de,
	beanhuo@micron.com,
	yangyingliang@huawei.com,
	asuk4.q@gmail.com,
	yibin.ding@unisoc.com,
	victor.shih@genesyslogic.com.tw,
	marex@denx.de,
	rafael.beims@toradex.com,
	robimarko@gmail.com,
	ricardo@foundries.io,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Date: Wed, 29 Nov 2023 17:05:33 +0100
Message-Id: <20231129160533.2827458-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
re-tune before switching to the RPMB partition would randomly cause
subsequent RPMB requests to fail with EILSEQ:
* data error -84, tigggered in __mmc_blk_ioctl_cmd()

This commit skips the retune when switching to RPMB.
Tested over several days with per minute RPMB reads.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 Fixes v1: kernel test robot identified typo causing build failure
           CIF_MANFID_SANDISK_SD --> CID_MANFID_SANDISK_SD

 drivers/mmc/core/block.c  | 6 +++++-
 drivers/mmc/core/card.h   | 7 +++++++
 drivers/mmc/core/quirks.h | 7 +++++++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 152dfe593c43..9b7ba6562a3b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -860,6 +860,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				return ret;
 		}
 		mmc_retune_pause(card->host);
+
+		/* Do not force retune before RPMB switch */
+		if (mmc_can_retune(card->host) &&
+		    mmc_card_broken_rpmb_retune(card))
+			card->host->need_retune = 0;
 	}

 	return ret;
@@ -3143,4 +3148,3 @@ module_exit(mmc_blk_exit);

 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index b7754a1b8d97..1e1555a15de9 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -85,6 +85,7 @@ struct mmc_fixup {
 #define CID_MANFID_MICRON       0x13
 #define CID_MANFID_SAMSUNG      0x15
 #define CID_MANFID_APACER       0x27
+#define CID_MANFID_SANDISK2     0x45
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
 #define CID_MANFID_KINGSTON_SD	0x9F
@@ -284,4 +285,10 @@ static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
 {
 	return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
 }
+
+static inline int mmc_card_broken_rpmb_retune(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_RPMB_RETUNE;
+}
+
 #endif
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index cca71867bc4a..56c79b6b3537 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -130,6 +130,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
 		  MMC_QUIRK_BROKEN_SD_DISCARD),

+	/*
+	 * SanDisk iNAND 7250 DG4064, this quirk shall disable the retune
+	 * operation enforced by default when switching to RPMB.
+	 */
+	MMC_FIXUP("DG4064", CID_MANFID_SANDISK2, 0x100, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_RPMB_RETUNE),
+
 	END_FIXUP
 };

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 7b12eebc5586..bd6986189e8b 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -296,6 +296,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
+#define MMC_QUIRK_BROKEN_RPMB_RETUNE	(1<<17) /* Don't force a retune before switching to RPMB */

 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
--
2.34.1

