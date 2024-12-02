Return-Path: <linux-mmc+bounces-4868-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C64D9E0159
	for <lists+linux-mmc@lfdr.de>; Mon,  2 Dec 2024 13:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359F0164FA6
	for <lists+linux-mmc@lfdr.de>; Mon,  2 Dec 2024 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5362220370D;
	Mon,  2 Dec 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0QxnT2wE"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC03203716
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140971; cv=none; b=rZJyjgGNr0RriHE8gA+lNEv1YkGpL/YBhkGQLqWPsMtE5DetYXYVCQK3kQJL+4hvYPhIkrF1cIMzpT36CRlUX2dsEOyiOF0LNRVvOk55oU3qGghYHhiGabORTMCRw0fEvqLsFDZkoYZEpKk34QM0fr3+pKewpV9ptUF5AivWF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140971; c=relaxed/simple;
	bh=6YzjV0NPQ5Asz3NMWwdStqqiu2ZFZDJL+XQN18G4jho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gww7she1bbfjqHFDf3Dbm4gmFWXB1Qd1a7pwWuK5ZesiXa+lUJN9YqABCbZiXGhcqb9M1ZwrpJVB5YN5SMQN9psVhipwCzhsWUAhks76YDADgAROc7bbtV8ZqCmTU0ryi/uu8zbWpBBvfVUnn7zEkll/MKjoPCxzXz5MdaqiA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0QxnT2wE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso38149855e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 04:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140967; x=1733745767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwrqUgzomeZAg551+85HwI0DROl0jONzf+FyxNyg5dI=;
        b=0QxnT2wEAppUE5irarxp4zFwY8qN5geBVep1eWjFhuUvRGJOLhYH4ubSPiq7fptojW
         c8swZxFourC5md75I0gkcvJlmFLEw7GgXJpoJtN4LtohjKT4ipg9JZpm1KI0zE+wwWHK
         Nrd9YINaVPr55/eQzj/12n8yB7PPRQ7EKEeT+hcOZOZIi4IWiB/ybd7OtedKqju9vtPK
         pbn9zmE2t6HweYHxJCNuCpz735vpTqFf9DdVCEBSu6ea72uH5loEyart+00JicuxJn1j
         mmcmrb1nM8cz+vMhnl4mGwcSFdwDswibN/GA2dkzQ6GWem/HFnSxAp06eccJQhz4/PTK
         srDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140967; x=1733745767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwrqUgzomeZAg551+85HwI0DROl0jONzf+FyxNyg5dI=;
        b=EkI4YS571sE7fKosNJvs8ps2WFxsWOEj+zfVFF18NAxI/6wDl7jryCWB//kQcCA8XW
         EmvMOGOYgsIlMJkV53bUdz3pNoqYA0+VukD6miScJDICm9OHvl/8ogYXk5RDE5PHdQF/
         vVLQbJCecqcMEKT2+Bp5eITrwbpHOxrZeiPIbgBNwiT6XhjLqKsyWH4UEn8hGiUnpGWb
         ZbJkcr7dSfFAmk5HiQoZDp4SG4jwx0slF/yTUPxhHLCSYva4cJPsouX9ckdE8IDeKSxo
         vzHgZwk4eCQ9x/5v93PvhESoJvbh+Pmi3uvUpaTTavl0jtSFL52f4uZP9J0gVPbbDufr
         Ikiw==
X-Forwarded-Encrypted: i=1; AJvYcCVRm5nSwyI8QXjSJIKh6Xro/j4oiRTaynORPVd04djzgkQsYxLm4AnHSAfdltyUShPkO2iP1msU30Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPhQczXzQhvrCL+G8aCDQvhMcOqrQpoOh+FQEkn8URXo9AoQ0m
	SeSTnXuq/EHJgK97yX+WKULHaZLPznbCq/L9ePUNio03hfQQXlYxr2wm5RvbAiY=
X-Gm-Gg: ASbGncviyuGI6yx9ev6PowzuYhAngaZCIE64iPVavarcRA6nVA+X77ln6HRl3dcWzjn
	nNMJsvRpauxAFdFOqtRo6JJVyNdIpIK0QlaYVrWQVMsTWnO65GRo1cQ7dg2AO3LVzyYypkhmlOU
	Vc6CrIxt/52aiyglDmS8RWfb0RAuaAqW1zguzokLkyO9KlGTEtKGU0E4DAWaf7tZd2rjzX8cr/0
	0tLtYG2DH01p3aGzyqBGT+tW2+boHcVsvGQvOMK
X-Google-Smtp-Source: AGHT+IG/w7cCjN0oKPl08ooPpL18eC2QfHH3rm9TU2c2V07Nmil57JLBdJ4jBndbMqB2SsBSN/dg+w==
X-Received: by 2002:a05:600c:198c:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-434a9e0ac32mr189639205e9.27.1733140965235;
        Mon, 02 Dec 2024 04:02:45 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:02:44 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Dec 2024 13:02:21 +0100
Subject: [PATCH RESEND v7 05/17] ice, ufs, mmc: use the blk_crypto_key
 struct when programming the key
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-wrapped-keys-v7-5-67c3ca3f3282@linaro.org>
References: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
In-Reply-To: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Asutosh Das <quic_asutoshd@quicinc.com>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9620;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Xxy7T1ivWX9tbiX/lU4uTl3nRxq9bf8iN/DI5qFBRo4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHSarEJ/NUdEhODEKyrsFZmobZ9td42n/5Va
 leOaiEpWfKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h0gAKCRARpy6gFHHX
 ciLJD/9WdWPTFWXr4k9CfLh5BwJ2ksXCgxTPX/hCV8uJPp36IJkZgXBK2kMQ/m4RKPB0AxPQtnC
 /3W1vMNHhU+aQblrj1haiomFSfr34M0Y6KDYpdlLWvDuVPs+QZ4DwSxiZtivQY4y9ccvuu1JXgM
 6BeWxRD8SdPHA+r7bPBEgfdKG0Ymf/yqhxU9/w27tu/7gV7+mP9hsxGeXB9k9jbklKwJ1tXy1Vq
 2zx6dGg3Gh16sjt27Dz6a+Cm9ake/TAhJHJlm5geNBOoCOW+IWHicXsH2ue77VO03xl9uJKsLsF
 pB4iKkF1IdIG8c4wkYijgXDcy/ywjNRSPnjQG10Vgg1SWNU/t5ThyR54F65TA/Imf/S0G/ycKYI
 ss5UgeyX/KgIyNeGsuB2PFqd75ILftltKR4g8m2uBqtfgCVayu/zn3y+wBbT3e0Y2H+r7GniuO2
 gwhoKbvhNy/IiqghWMS3lhgSjqIDtrw6cExBYPCbS3cC07eGiQF+kuyalt7AN59+E+jVSeiS1TD
 gofrBL/OD8yyn+0fqFVmrbr00Ec4uhOTIocMOq7fx+728BpJexy5SIq+R3l3ofRjzhEyCLyhGZw
 Lmrs03J1HFzdWl8mguECrWfdf54OJdSY7aGvPX8xEJsEap9v8qqVsbn/grRlmlec8tF3E2iKO/Q
 c6bcieyRsfI3ZqA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

The program key ops in the storage controller does not pass on the
blk_crypto_key structure to ICE, this is okay with raw keys of standard
AES XTS sizes. However, wrapped keyblobs can be of any size and in
preparation for that, modify the ICE and storage controller APIs to
accept blk_crypto_key which can carry larger keys and indicate their
size.

Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mmc/host/cqhci-crypto.c  | 7 ++++---
 drivers/mmc/host/cqhci.h         | 2 ++
 drivers/mmc/host/sdhci-msm.c     | 6 ++++--
 drivers/soc/qcom/ice.c           | 6 +++---
 drivers/ufs/core/ufshcd-crypto.c | 7 ++++---
 drivers/ufs/host/ufs-qcom.c      | 6 ++++--
 include/soc/qcom/ice.h           | 5 +++--
 include/ufs/ufshcd.h             | 1 +
 8 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/cqhci-crypto.c b/drivers/mmc/host/cqhci-crypto.c
index 6652982410ec5..91da6de1d6501 100644
--- a/drivers/mmc/host/cqhci-crypto.c
+++ b/drivers/mmc/host/cqhci-crypto.c
@@ -32,6 +32,7 @@ cqhci_host_from_crypto_profile(struct blk_crypto_profile *profile)
 }
 
 static int cqhci_crypto_program_key(struct cqhci_host *cq_host,
+				    const struct blk_crypto_key *bkey,
 				    const union cqhci_crypto_cfg_entry *cfg,
 				    int slot)
 {
@@ -39,7 +40,7 @@ static int cqhci_crypto_program_key(struct cqhci_host *cq_host,
 	int i;
 
 	if (cq_host->ops->program_key)
-		return cq_host->ops->program_key(cq_host, cfg, slot);
+		return cq_host->ops->program_key(cq_host, bkey, cfg, slot);
 
 	/* Clear CFGE */
 	cqhci_writel(cq_host, 0, slot_offset + 16 * sizeof(cfg->reg_val[0]));
@@ -99,7 +100,7 @@ static int cqhci_crypto_keyslot_program(struct blk_crypto_profile *profile,
 		memcpy(cfg.crypto_key, key->raw, key->size);
 	}
 
-	err = cqhci_crypto_program_key(cq_host, &cfg, slot);
+	err = cqhci_crypto_program_key(cq_host, key, &cfg, slot);
 
 	memzero_explicit(&cfg, sizeof(cfg));
 	return err;
@@ -113,7 +114,7 @@ static int cqhci_crypto_clear_keyslot(struct cqhci_host *cq_host, int slot)
 	 */
 	union cqhci_crypto_cfg_entry cfg = {};
 
-	return cqhci_crypto_program_key(cq_host, &cfg, slot);
+	return cqhci_crypto_program_key(cq_host, NULL, &cfg, slot);
 }
 
 static int cqhci_crypto_keyslot_evict(struct blk_crypto_profile *profile,
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index fab9d74445ba7..06099fd32f23e 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/wait.h>
 #include <linux/irqreturn.h>
+#include <linux/blk-crypto.h>
 #include <asm/io.h>
 
 /* registers */
@@ -291,6 +292,7 @@ struct cqhci_host_ops {
 	void (*post_disable)(struct mmc_host *mmc);
 #ifdef CONFIG_MMC_CRYPTO
 	int (*program_key)(struct cqhci_host *cq_host,
+			   const struct blk_crypto_key *bkey,
 			   const union cqhci_crypto_cfg_entry *cfg, int slot);
 #endif
 	void (*set_tran_desc)(struct cqhci_host *cq_host, u8 **desc,
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e00208535bd1c..b8770524c0087 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1859,6 +1859,7 @@ static __maybe_unused int sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
  * vendor-specific SCM calls for this; it doesn't support the standard way.
  */
 static int sdhci_msm_program_key(struct cqhci_host *cq_host,
+				 const struct blk_crypto_key *bkey,
 				 const union cqhci_crypto_cfg_entry *cfg,
 				 int slot)
 {
@@ -1866,6 +1867,7 @@ static int sdhci_msm_program_key(struct cqhci_host *cq_host,
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	union cqhci_crypto_cap_entry cap;
+	u8 ice_key_size;
 
 	/* Only AES-256-XTS has been tested so far. */
 	cap = cq_host->crypto_cap_array[cfg->crypto_cap_idx];
@@ -1873,11 +1875,11 @@ static int sdhci_msm_program_key(struct cqhci_host *cq_host,
 		cap.key_size != CQHCI_CRYPTO_KEY_SIZE_256)
 		return -EINVAL;
 
+	ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
 	if (cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE)
 		return qcom_ice_program_key(msm_host->ice,
 					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
-					    QCOM_ICE_CRYPTO_KEY_SIZE_256,
-					    cfg->crypto_key,
+					    ice_key_size, bkey,
 					    cfg->data_unit_size, slot);
 	else
 		return qcom_ice_evict_key(msm_host->ice, slot);
diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 393d2d1d275f1..e89baaf574bc1 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -163,8 +163,8 @@ EXPORT_SYMBOL_GPL(qcom_ice_suspend);
 
 int qcom_ice_program_key(struct qcom_ice *ice,
 			 u8 algorithm_id, u8 key_size,
-			 const u8 crypto_key[], u8 data_unit_size,
-			 int slot)
+			 const struct blk_crypto_key *bkey,
+			 u8 data_unit_size, int slot)
 {
 	struct device *dev = ice->dev;
 	union {
@@ -183,7 +183,7 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 		return -EINVAL;
 	}
 
-	memcpy(key.bytes, crypto_key, AES_256_XTS_KEY_SIZE);
+	memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
 
 	/* The SCM call requires that the key words are encoded in big endian */
 	for (i = 0; i < ARRAY_SIZE(key.words); i++)
diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 7d3a3e228db0d..33083e0cad6e1 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -18,6 +18,7 @@ static const struct ufs_crypto_alg_entry {
 };
 
 static int ufshcd_program_key(struct ufs_hba *hba,
+			      const struct blk_crypto_key *bkey,
 			      const union ufs_crypto_cfg_entry *cfg, int slot)
 {
 	int i;
@@ -27,7 +28,7 @@ static int ufshcd_program_key(struct ufs_hba *hba,
 	ufshcd_hold(hba);
 
 	if (hba->vops && hba->vops->program_key) {
-		err = hba->vops->program_key(hba, cfg, slot);
+		err = hba->vops->program_key(hba, bkey, cfg, slot);
 		goto out;
 	}
 
@@ -89,7 +90,7 @@ static int ufshcd_crypto_keyslot_program(struct blk_crypto_profile *profile,
 		memcpy(cfg.crypto_key, key->raw, key->size);
 	}
 
-	err = ufshcd_program_key(hba, &cfg, slot);
+	err = ufshcd_program_key(hba, key, &cfg, slot);
 
 	memzero_explicit(&cfg, sizeof(cfg));
 	return err;
@@ -107,7 +108,7 @@ static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
 	 */
 	union ufs_crypto_cfg_entry cfg = {};
 
-	return ufshcd_program_key(hba, &cfg, slot);
+	return ufshcd_program_key(hba, NULL, &cfg, slot);
 }
 
 /*
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 68040b2ab5f82..44fb4a4c0f2d7 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -150,6 +150,7 @@ static inline int ufs_qcom_ice_suspend(struct ufs_qcom_host *host)
 }
 
 static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
+				    const struct blk_crypto_key *bkey,
 				    const union ufs_crypto_cfg_entry *cfg,
 				    int slot)
 {
@@ -157,6 +158,7 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 	union ufs_crypto_cap_entry cap;
 	bool config_enable =
 		cfg->config_enable & UFS_CRYPTO_CONFIGURATION_ENABLE;
+	u8 ice_key_size;
 
 	/* Only AES-256-XTS has been tested so far. */
 	cap = hba->crypto_cap_array[cfg->crypto_cap_idx];
@@ -164,11 +166,11 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 	    cap.key_size != UFS_CRYPTO_KEY_SIZE_256)
 		return -EOPNOTSUPP;
 
+	ice_key_size = QCOM_ICE_CRYPTO_KEY_SIZE_256;
 	if (config_enable)
 		return qcom_ice_program_key(host->ice,
 					    QCOM_ICE_CRYPTO_ALG_AES_XTS,
-					    QCOM_ICE_CRYPTO_KEY_SIZE_256,
-					    cfg->crypto_key,
+					    ice_key_size, bkey,
 					    cfg->data_unit_size, slot);
 	else
 		return qcom_ice_evict_key(host->ice, slot);
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index 5870a94599a25..9dd835dba2a78 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -7,6 +7,7 @@
 #define __QCOM_ICE_H__
 
 #include <linux/types.h>
+#include <linux/blk-crypto.h>
 
 struct qcom_ice;
 
@@ -30,8 +31,8 @@ int qcom_ice_resume(struct qcom_ice *ice);
 int qcom_ice_suspend(struct qcom_ice *ice);
 int qcom_ice_program_key(struct qcom_ice *ice,
 			 u8 algorithm_id, u8 key_size,
-			 const u8 crypto_key[], u8 data_unit_size,
-			 int slot);
+			 const struct blk_crypto_key *bkey,
+			 u8 data_unit_size, int slot);
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
 #endif /* __QCOM_ICE_H__ */
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index d7aca9e61684f..bc6f08397769c 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -373,6 +373,7 @@ struct ufs_hba_variant_ops {
 				struct devfreq_dev_profile *profile,
 				struct devfreq_simple_ondemand_data *data);
 	int	(*program_key)(struct ufs_hba *hba,
+			       const struct blk_crypto_key *bkey,
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	int	(*fill_crypto_prdt)(struct ufs_hba *hba,
 				    const struct bio_crypt_ctx *crypt_ctx,

-- 
2.45.2


