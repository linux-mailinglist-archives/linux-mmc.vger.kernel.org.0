Return-Path: <linux-mmc+bounces-4804-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D457E9D6F60
	for <lists+linux-mmc@lfdr.de>; Sun, 24 Nov 2024 14:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959D32818BE
	for <lists+linux-mmc@lfdr.de>; Sun, 24 Nov 2024 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5441D63E2;
	Sun, 24 Nov 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISMoCNLK"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B511D63DD;
	Sun, 24 Nov 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452624; cv=none; b=A970PmiQykttbhW0pLrI+2MoseRs8RS5y9MXBWqRwI61aWDHHsRJsJP8RoDD4fwItuquZHMt5V9GSQJwNnKuNBR+YrBN75e5kF/wQ2yZO+yCzdXJc69NJtqBajRyd3yX+TRrL6e4lMSxVL5exMldffAmLcDGRQTQcs1fXpHp2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452624; c=relaxed/simple;
	bh=XT4433PseE0IFuyGYpfnghDsEctmtiZB3Nd4jfNBuwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvzh+UNyTfiIPQHhQ194pAxIekLR44oi4VtpV2xRUhHQkvp4rPPqODdfKfl2izzS4o0r3DfvVJmPYSO3imdC1scuPJ/Ddh20EtkwCVTJdZp1Bw+QFJcPq9rq+V6Nc/s1GHP6RfHy8/ayNwqwo7HbaHjzz1kOoeqHDSWZV1Ir6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISMoCNLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A6BC4CED3;
	Sun, 24 Nov 2024 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452623;
	bh=XT4433PseE0IFuyGYpfnghDsEctmtiZB3Nd4jfNBuwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISMoCNLKDG8FlWLkoJUYTOxrY7srCdM57psBZToDGMuj1hHpIhUFyJzyf2oeZiY2P
	 /j/0ygMkabIg2vWcCxgMbR0hRfnTt1DqLK2NP8mbeyD/3SdqPom42UWT8RhgRZnd0D
	 PTGQy5SdaVqwv1HiSv10KlFo2RJmnh1Hhg62n8tGCV1q+N8IvcQO4evppVoJB/fSAQ
	 ph1xOtxDRDEhAsjwrH55gtwWiiYee4s6GEsMBrqjrIw6AWGtWbaUrv0xKQPVS00POV
	 IKEpIxbnE6oObn+hD14iTyH3vBp9bYWgBLhK7rN4+rbvaRdTdsbkBe2bJX7dyuZTN4
	 JomlO2vRL59HA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keita Aihara <keita.aihara@sony.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	avri.altman@wdc.com,
	adrian.hunter@intel.com,
	jonathan@raspberrypi.com,
	dsimic@manjaro.org,
	victor.shih@genesyslogic.com.tw,
	ricardo@marliere.net,
	cw9316.lee@samsung.com,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 14/23] mmc: core: Add SD card quirk for broken poweroff notification
Date: Sun, 24 Nov 2024 07:48:25 -0500
Message-ID: <20241124124919.3338752-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124919.3338752-1-sashal@kernel.org>
References: <20241124124919.3338752-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Keita Aihara <keita.aihara@sony.com>

[ Upstream commit cd068d51594d9635bf6688fc78717572b78bce6a ]

GIGASTONE Gaming Plus microSD cards manufactured on 02/2022 report that
they support poweroff notification and cache, but they are not working
correctly.

Flush Cache bit never gets cleared in sd_flush_cache() and Poweroff
Notification Ready bit also never gets set to 1 within 1 second from the
end of busy of CMD49 in sd_poweroff_notify().

This leads to I/O error and runtime PM error state.

I observed that the same card manufactured on 01/2024 works as expected.

This problem seems similar to the Kingston cards fixed with
commit c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston
Canvas Go Plus from 11/2019") and should be handled using quirks.

CID for the problematic card is here.
12345641535443002000000145016200

Manufacturer ID is 0x12 and defined as CID_MANFID_GIGASTONE as of now,
but would like comments on what naming is appropriate because MID list
is not public and not sure it's right.

Signed-off-by: Keita Aihara <keita.aihara@sony.com>
Link: https://lore.kernel.org/r/20240913094417.GA4191647@sony.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/card.h   | 7 +++++++
 drivers/mmc/core/quirks.h | 9 +++++++++
 drivers/mmc/core/sd.c     | 2 +-
 include/linux/mmc/card.h  | 1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index b7754a1b8d978..8476754b1b170 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -82,6 +82,7 @@ struct mmc_fixup {
 #define CID_MANFID_SANDISK_SD   0x3
 #define CID_MANFID_ATP          0x9
 #define CID_MANFID_TOSHIBA      0x11
+#define CID_MANFID_GIGASTONE    0x12
 #define CID_MANFID_MICRON       0x13
 #define CID_MANFID_SAMSUNG      0x15
 #define CID_MANFID_APACER       0x27
@@ -284,4 +285,10 @@ static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
 {
 	return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
 }
+
+static inline int mmc_card_broken_sd_poweroff_notify(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY;
+}
+
 #endif
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 92905fc46436d..89b512905be14 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -25,6 +25,15 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
 		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
 
+	/*
+	 * GIGASTONE Gaming Plus microSD cards manufactured on 02/2022 never
+	 * clear Flush Cache bit and set Poweroff Notification Ready bit.
+	 */
+	_FIXUP_EXT("ASTC", CID_MANFID_GIGASTONE, 0x3456, 2022, 2,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_BROKEN_SD_CACHE | MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY,
+		   EXT_CSD_REV_ANY),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 12fe282bea77e..9e62cb7055fef 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1107,7 +1107,7 @@ static int sd_parse_ext_reg_power(struct mmc_card *card, u8 fno, u8 page,
 	card->ext_power.rev = reg_buf[0] & 0xf;
 
 	/* Power Off Notification support at bit 4. */
-	if (reg_buf[1] & BIT(4))
+	if ((reg_buf[1] & BIT(4)) && !mmc_card_broken_sd_poweroff_notify(card))
 		card->ext_power.feature_support |= SD_EXT_POWER_OFF_NOTIFY;
 
 	/* Power Sustenance support at bit 5. */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f34407cc27888..543446392776f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -294,6 +294,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
 #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
 #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
+#define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
 
 	bool			written_flag;	/* Indicates eMMC has been written since power on */
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
-- 
2.43.0


