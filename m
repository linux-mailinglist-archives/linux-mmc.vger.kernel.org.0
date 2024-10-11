Return-Path: <linux-mmc+bounces-4321-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D69099AC11
	for <lists+linux-mmc@lfdr.de>; Fri, 11 Oct 2024 20:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF94E1C23F0A
	for <lists+linux-mmc@lfdr.de>; Fri, 11 Oct 2024 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E531EABD1;
	Fri, 11 Oct 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="h6Zc0ytZ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8231D14EE
	for <linux-mmc@vger.kernel.org>; Fri, 11 Oct 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672896; cv=none; b=FW7fHj5ddiiwtGmjUTDgtgx7BPGuPovBoHZt1y4TAjzjz4mrnQ+l6/M3JSWLlkBu4Bd8EIiBQUndT/5uYgBh347yjC2Wf4qhn3Lh5zj3/Po0mHSqeiTtVUSt1XU/WIDDcy1x+vONwmDDOQSAg7hmldrghky/1PYcXQPHZFKO9jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672896; c=relaxed/simple;
	bh=av5ekMZJt1CCKTT+LM8n2/ThdeWKjLFb14Wc2226m9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezQa8/RJDaLKfJGDJ2fBEudnBzwrx+pI359kbLZCOHiFHYCrvOzgUl8bdFj3Ap2nwhkyPx9on3HefzBf4w9dk3YIhllvlkz7vWgXFKtkd7zPvZZEewGAYLjeGx9R52qc3tRf+0D5Gjo9MLieB6l+JyiPPUbICquKjhXCSvvV3uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=h6Zc0ytZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so18066275e9.2
        for <linux-mmc@vger.kernel.org>; Fri, 11 Oct 2024 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672887; x=1729277687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGWAGLSPgWn5/AObiWCo6XP/hZPo7gBwFrZhxAMnG4g=;
        b=h6Zc0ytZxL7+KtG/EMYIS+NIm4lVm/jz7o55M999zBfhOOO2+it8g1vrx4UdWzLXsl
         Kbq7b+rIEkVKUCYfF+rIVIBNuap7ZWK3IAvJFatRoFmvZ/vBhyWByAJh3q9k9+Zqfce3
         dMFeS9FyYtd7ihXyqb7/Yw2BL5sWpSVjdAetShELpadABZWKElZIzcllA0uxBbDy1ivJ
         PxcX0nNWeSOtQI1NqpBm0+OTOjTijuB1RohA3FSYLc9m1dZVRfX2E8og+/Ri+J6wjdH1
         edAuX6XtDUkX+MNBkFmp89MiUhcOMLdgX4Xx30KHCp+R2tv14algxzxbRzVJKahcLK2Z
         7Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672887; x=1729277687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGWAGLSPgWn5/AObiWCo6XP/hZPo7gBwFrZhxAMnG4g=;
        b=KJyDBFq1Kx++agt25t2KLDI53qYQNr/hJx/QbeC/tmNvA86SRLvlHLnpPtVSG5gXf/
         6yincON/g/wk2GWaxax2OhvnHNPNZj6A2Ckrt16B8Gne5Zpq/sHJ85k0eabwiE5TS4QK
         hunz58D2GKpjVqEP7tU2GDemYKKWwqOSSmTlBuls20fPifRX1Y8L5YD4YpP2FWIVie5I
         11e9XZKeggVUfXXDfmnaEhFWStpQi6ClaAKv9AavT711i1a+vzMdhKLub5bWJSm/ZlBj
         4sq9hO0qm2OgicNrvvBpBGtJxjD0ZrLG5T0briJw9sM+V1bGkXa27cz0N8IXOcdOcvDc
         QHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7zj9eXGJ/V8WOi+W3dkPMBxcv1b1b3UHtvAXQcsFbVlXNDmykZDClQ69PmtLQwltJs1zhVUp9c7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+aJ3FfCrxVohT4mHO2Hc2m6OmWzzAl2mCpzzgezjw7GYhgwE
	I8twPzWhFid7ujYW2SmoZkUGLz6sTiiGmmUHk2zPlFm9OyBesToL2vDxixCyOkM=
X-Google-Smtp-Source: AGHT+IGaXZcgHcQXsKgnIWWdTg/5GMBmPlNoM6B2HQGTUTRug1kQ9c6bJXfJY9x9FzLOvWAx7apu7w==
X-Received: by 2002:a05:600c:3acd:b0:42c:b0a4:6b67 with SMTP id 5b1f17b1804b1-4312561a40cmr3174535e9.34.1728672886762;
        Fri, 11 Oct 2024 11:54:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:12 +0200
Subject: [PATCH v7 13/17] ufs: core: add support for deriving the software
 secret
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-13-e3f7a752059b@linaro.org>
References: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
In-Reply-To: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Asutosh Das <quic_asutoshd@quicinc.com>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2593;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ThUnFUzOE+WKlyswQqxKI3kiG9w6jnBt19VmRqdLgs0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRg10xeWiKDWP5UaAufiEjsF2gcIgHfmgp4T
 tnwZQSIL6eJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0YAAKCRARpy6gFHHX
 cqb2D/0ff6fHIXbLO8/Uxmcs7WNE+Wn7CDOZiPxGkQlls8jo4E6YYu0rErTuq3wbAa1Y9+bMQLf
 o7uIQo1wzHM5cU5zJ7oVcSqnvG0sMlSKIwj1K/6gQUy4gsiU97RmHk68ik4VveCUHtPdXfyNZgU
 YDTcb3VrSUgfYzsa9hQ3jACRv2XLSp+E4IFcQz0R6T8eBNY6v7SkLqbW01PljKlf1rIQX1OLY5h
 kJv65KqBSIezc684Nx4anF06LJNfiljxDTT3C786GXEdQPzrqnXEANQa5Dw4eHThrnqKzbsZL3m
 uHoqlHbb0/rHUVc2OfuLjgPyPkdaf74KCVIOVPQIgWhdgbmyzDoJ6z9sK2euPkrNEcfEjjbNj2n
 vqMa7ZELaszAdd5SS635XpOdUBkl1LyTF2oufFLgYW99QbjRga+kyWAP1lNgBea05/oeBM5eC36
 pnRBw/h48wNzxAwHNn+ty0u/z/9scCZgJNohx1tlDik2b84yydYEjmeNQm4GwJ22ukzCFweR7wJ
 V9y0bCzx616ba74YFEODkeCXuD2tA87lCdaF2/3wtJeQciVWIBeTnY7fBIO1OmjydEpw0oyCG/A
 Wc+lnTJSsZrcKqJ1WDKYLjb5JzMGCPusnDSmGW6svLAavGy77Q+lUc8PmqLH0uFp6rogpu866Ae
 J3NLk1P+mvvW6aw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Extend the UFS core to allow calling the block layer's callback for
deriving the software secret from a wrapped key. This is needed as in
most cases the wrapped key support will be vendor-specific and the
implementation will live in the specific UFS driver.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 15 +++++++++++++++
 include/ufs/ufshcd.h             |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 64389e876910..2530239d42af 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -113,6 +113,20 @@ static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
 	return ufshcd_program_key(hba, NULL, &cfg, slot);
 }
 
+static int ufshcd_crypto_derive_sw_secret(struct blk_crypto_profile *profile,
+					  const u8 wkey[], size_t wkey_size,
+					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->derive_sw_secret)
+		return hba->vops->derive_sw_secret(hba, wkey, wkey_size,
+						   sw_secret);
+
+	return -EOPNOTSUPP;
+}
+
 /*
  * Reprogram the keyslots if needed, and return true if CRYPTO_GENERAL_ENABLE
  * should be used in the host controller initialization sequence.
@@ -134,6 +148,7 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
 static const struct blk_crypto_ll_ops ufshcd_crypto_ops = {
 	.keyslot_program	= ufshcd_crypto_keyslot_program,
 	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
+	.derive_sw_secret	= ufshcd_crypto_derive_sw_secret,
 };
 
 static enum blk_crypto_mode_num
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 19c36f4ca381..d74a26a36f5b 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -372,6 +372,9 @@ struct ufs_hba_variant_ops {
 	int	(*program_key)(struct ufs_hba *hba,
 			       const struct blk_crypto_key *bkey,
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
+	int	(*derive_sw_secret)(struct ufs_hba *hba, const u8 wkey[],
+				    unsigned int wkey_size,
+				    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
 	int	(*fill_crypto_prdt)(struct ufs_hba *hba,
 				    const struct bio_crypt_ctx *crypt_ctx,
 				    void *prdt, unsigned int num_segments);

-- 
2.43.0


