Return-Path: <linux-mmc+bounces-4870-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553489E01BE
	for <lists+linux-mmc@lfdr.de>; Mon,  2 Dec 2024 13:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F04B26CF3
	for <lists+linux-mmc@lfdr.de>; Mon,  2 Dec 2024 12:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3E205AA5;
	Mon,  2 Dec 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SREQ59kL"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9C20408C
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140974; cv=none; b=gyq3ZuhyKZnkMXtMeuDHk4i9vIubGWPiS9u/zAwVO1otU/hfGkgwT7MncRoQWk09NWj7R+B1cb8dsmNTyJXlxQ3NKPiT0tgC/J7GDiDb+VnRgrJxEk2AVLtBSAliJVnNVUILio5oaRkd5+X1fHlZfe5cSz7yXtSwSfvb3UBw5hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140974; c=relaxed/simple;
	bh=2ORU5vyUJ27lap9sqAiI3qTrLNQQhoC73WWhD6bjviY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CAcC5pEi+ltHS2WXjXNpzVzLaGaWk3CHflNknL81N5POmofdOb8wGRDi83LksIVb2WX7bPw06CraXBv7pjrRJRFZdgWFAt/48fhC6w5wxIw/2dqUwzKxPxWJ9MIXRGKv4BL7rF3Jd5uAdSo95nZEbucMgzv09P0Q2ohWmuMY/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SREQ59kL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434aa222d96so52630275e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 04:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140967; x=1733745767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5lbIjJ4pCG8r8J9xIS9Rd3wgRBn4855nSdT5ZJ6kC4=;
        b=SREQ59kL3ga7GzxjqD5aXpP9UTOp8b0Lp+i2xtybWbfF/R5Y0gFY4MJF2bxceSW1qq
         twqGL+DX6wBj16+avqPZCo1rYh1dr11k/ffnTsCNyyRIMrlam38HUA851ubfoTet32us
         AKeNHLnLcqBLVPx2mjM/4r2AZRY4pq7lSqDUvU9KZPvMqrEAE74nC/ThfC38A/gAxznO
         SdihYitd2kkCpcnm+nT1Uc4Glu74NpU5wshq2TNpne2hwN/5xpgt/YZ0rMZdQSUuq2S5
         AaEBZDmXMB5DmhlkmZfYjdk6hTfr5Xt5Kuqs3bZxIVHASyPlF5zTtu2w9TPq2cxua+Lf
         buWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140967; x=1733745767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5lbIjJ4pCG8r8J9xIS9Rd3wgRBn4855nSdT5ZJ6kC4=;
        b=FobFfmn6Czv9Cc5h2xliprMEM+RdcWSosiDD7pgTW9zslmL7otreby1R3k0KpCOMFR
         H4xlG6RHmp6BWiJW2w8L408Y6o2nI1THYAwR63s9rkhvsqP8ZlrgOp1y68gWR3FNXoti
         fXKCg1h68LfMuGVG35M1hDRi41f3I4UoNlxHW3BLM/rZNae3RU5R44606BAmINUkhaec
         KX1h4vNwZTDY8zcHP/2AtIM+wSLseFBy5t8X8p/myGc7ySxYDdoO8GC0IAobKsRp4qEQ
         FpLSeizJF3gsoGu8aT72z6Xuy5PJ7LdESa49AVMeP7qqv04wLvDJViXTEvfKwq397/Q1
         0gNA==
X-Forwarded-Encrypted: i=1; AJvYcCV4lTWpXp6+qJ1nF7XB+D0YtSX9EY4rAcqhgvY/8EL2ygMxC0jsuZwU1K6YeEJL5Ze6r3Wh57Wabow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzatDjIzE1LC4coa2FMpc7uZAcJpq2olg0IVVgJSCR0ZYCNffgU
	0of8hQcSFnTcdxSRTJifzzho8CXDBWMN3psiCk4q7PFEUr09NVEecqaFffgEInI=
X-Gm-Gg: ASbGncuDXvrexU6UWGs/72D384dPsde7IseKdVkdwEF7MmWwmXvXZwPf3dy4KacrHVo
	CCcRBgsB2r5kf9zU9Axif6ijK+Ax7tQRAeCF9qdMkyVKdi+hs9hi8D9FoaUVYRljoJYhuQjUEEq
	iW3zk3dhtZ1suHNle3U/1K+SeqQMwVoUecG8ydqJEphdJegnbWy4e1GqlojOkQF9h2Ldo4lRuD4
	ePK8WOBiffsykfpabjjaaCkknts2QfFTDGn/HQt
X-Google-Smtp-Source: AGHT+IHQAyekXbdAXZ7eydZRNVx2vlbKBM8IKXEW49sElJ/U7e3rXwUNnq8MwjxBEeFibtagQDeTrA==
X-Received: by 2002:a05:600c:3585:b0:434:a04d:1670 with SMTP id 5b1f17b1804b1-434a9d4f86dmr259111775e9.0.1733140966888;
        Mon, 02 Dec 2024 04:02:46 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:02:46 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Dec 2024 13:02:22 +0100
Subject: [PATCH RESEND v7 06/17] firmware: qcom: scm: add a call for
 deriving the software secret
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-wrapped-keys-v7-6-67c3ca3f3282@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4754;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=wotGjX4ZTp3jBAnHlA+0tTqo+DEvuJKXXEnuWdkW8m0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHTdc124fFeQJuf7Q4Szt+eF8iUREMbzDgTo
 ZfwiG+IpcCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h0wAKCRARpy6gFHHX
 ctmGEADNdGvvGUYSlzGzUnBCi7/j35SwFxgaa6QN+8TI9JXd8mR3ZZ73L+Gmt7gpQym2/zRyEAl
 yF9/T9SK51RnNQvukU0EOstfpk9NWNgC2d/UtA8jk7/QqKPnhyny1XqDVqVpQlrPJAGY29KYjO/
 ME4Nc4nzYQhFHaGF8+iadJD2oKXkgQLq1Z7ykIzTVLkqeaq79bHA3uhFwLCbhLq6HHvZD2K4GiY
 96E2ByHsy5IA0qauyMOac6NmaXLo7WA8qqgThdJLsmjSCiOyWnLRpsdGlvvZXA4+58mhW/+JRU5
 P1MadkpeijDlZ/Khp8aJdiTi7eu1yghd90ZgFMXCum14b/G2lzXSXxz8xhpETWtdpqSc7YLqF2+
 pwPIiFY8lbELeKrUJY6oOeMXlbzlwY42/TI0rnYaymh+C0XgQGTrgJd1vWe6b70up1xJiwOeC4k
 NWBgKKYYfvMJXcqWW4CFRZIWlxsKt4h9PmKZ7VEC9BLe8aCwVnjcrvdC8RijQqXtPKtRGGOdFTN
 JkIuz5tVVVhwN+Sn5iYXMAT1Lhuu5iQRc4F4jawLqNLXO6gmzkQl9z1UsKQJzM7mdWLxIbZtlEe
 u9A095ThTUabhV8PLKo9qX8UaIhlpPnqgzlTmptY9kqpqdQNGy0pCpRSRCPGVGgIwhsngV3Uw/Z
 zE2EoBf2tLqlt9w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Inline storage encryption may require deriving a software secret from
storage keys added to the kernel.

For raw keys, this can be directly done in the kernel as keys are not
encrypted in memory.

However, hardware wrapped keys can only be unwrapped by the HW wrapping
entity. In case of Qualcomm's wrapped key solution, this is done by the
Hardware Key Manager (HWKM) from Trustzone.

Add a new SCM call which provides a hook to the software secret crypto
profile API provided by the block layer.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 65 ++++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |  1 +
 include/linux/firmware/qcom/qcom_scm.h |  2 ++
 3 files changed, 68 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 72bf87ddcd969..d523ce671997e 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1279,6 +1279,71 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
 
+/**
+ * qcom_scm_derive_sw_secret() - Derive software secret from wrapped key
+ * @wkey: the hardware wrapped key inaccessible to software
+ * @wkey_size: size of the wrapped key
+ * @sw_secret: the secret to be derived which is exactly the secret size
+ * @sw_secret_size: size of the sw_secret
+ *
+ * Derive a software secret from a hardware wrapped key for software crypto
+ * operations.
+ * For wrapped keys, the key needs to be unwrapped, in order to derive a
+ * software secret, which can be done in the hardware from a secure execution
+ * environment.
+ *
+ * For more information on sw secret, please refer to "Hardware-wrapped keys"
+ * section of Documentation/block/inline-encryption.rst.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
+			      u8 *sw_secret, size_t sw_secret_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_DERIVE_SW_SECRET,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW,
+					 QCOM_SCM_VAL, QCOM_SCM_RW,
+					 QCOM_SCM_VAL),
+		.args[1] = wkey_size,
+		.args[3] = sw_secret_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	int ret;
+
+	void *wkey_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							    wkey_size,
+							    GFP_KERNEL);
+	if (!wkey_buf)
+		return -ENOMEM;
+
+	void *secret_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       sw_secret_size,
+							       GFP_KERNEL);
+	if (!secret_buf) {
+		ret = -ENOMEM;
+		goto out_free_wrapped;
+	}
+
+	memcpy(wkey_buf, wkey, wkey_size);
+	desc.args[0] = qcom_tzmem_to_phys(wkey_buf);
+	desc.args[2] = qcom_tzmem_to_phys(secret_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(sw_secret, secret_buf, sw_secret_size);
+
+	memzero_explicit(secret_buf, sw_secret_size);
+
+out_free_wrapped:
+	memzero_explicit(wkey_buf, wkey_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_derive_sw_secret);
+
 /**
  * qcom_scm_hdcp_available() - Check if secure environment supports HDCP.
  *
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index e36b2f67607fc..55547ed27edd9 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -128,6 +128,7 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_SVC_ES			0x10	/* Enterprise Security */
 #define QCOM_SCM_ES_INVALIDATE_ICE_KEY	0x03
 #define QCOM_SCM_ES_CONFIG_SET_ICE_KEY	0x04
+#define QCOM_SCM_ES_DERIVE_SW_SECRET	0x07
 
 #define QCOM_SCM_SVC_HDCP		0x11
 #define QCOM_SCM_HDCP_INVOKE		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 4621aec0328c2..b843678bc3ee4 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -105,6 +105,8 @@ bool qcom_scm_ice_available(void);
 int qcom_scm_ice_invalidate_key(u32 index);
 int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 			 enum qcom_scm_ice_cipher cipher, u32 data_unit_size);
+int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
+			      u8 *sw_secret, size_t sw_secret_size);
 
 bool qcom_scm_hdcp_available(void);
 int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);

-- 
2.45.2


