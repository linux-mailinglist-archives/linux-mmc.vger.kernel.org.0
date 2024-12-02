Return-Path: <linux-mmc+bounces-4878-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8209E0198
	for <lists+linux-mmc@lfdr.de>; Mon,  2 Dec 2024 13:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4A9283779
	for <lists+linux-mmc@lfdr.de>; Mon,  2 Dec 2024 12:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518220ADEE;
	Mon,  2 Dec 2024 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aIcS4l5N"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4B20A5C8
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140990; cv=none; b=pnqG/A0kJWpncuF6lKsCbWS4NMQDsqMTT9q8sXbY06lwQ+n5yHfo9abmsv84mUc6CFjlQMAzMLdVGVf0NCsfPEZTu9lEH/D0G5LJXMKJ0rhHP0FAZMbwUDKmDDOI4b7K5MwuKeJCrs48nrDV6El80QExczIlGIpo/uillEZ9VXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140990; c=relaxed/simple;
	bh=IN6etAo6wtAFxbXGT9XJbAOrzWvZ9os6hEZ0IsjibBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knj9sWxOWTNQwJ4pYSydM7HPcZcYQhb5OSSSwoo2J+0jGl7y67CC7GQ/e2jHDh/Y2W0q8l9Hifkj3D6/rcGslsoTpQc4diougifyT0mYrFShFIrZU5XOPPeYJPVChPwr/vQMBUPwdrjgmbT2oBRX1dL7sPsrQBGWeNyfi3SiNFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aIcS4l5N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a10588f3so25932845e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 04:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733140986; x=1733745786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7TOWAjI6mgo3typHSgU/6g6JMqxt2KgeMAkh5f6OGU=;
        b=aIcS4l5NbHMrEiSI+nw4Jcgf9dP8e8hnpkw3P9T9ebrItCQgsgqybQmnKrBZJyOVgZ
         8fzMdvi021LZDdD5BXBEwkG5/qZIOJYLXvyd12nfcFq+MpHTZSwXSThJv/qXnei7Nwh/
         +9mESwS1lOE9HoH0JO2DD3QJh1PUqnX/US4Dbk4K00+rCso3HwQxGJ9+XuxgIbTHQdWz
         YWmPDJbSfbRl+CJ2G4pRG1XD/LHk1csEBJIu6iymblJJ4MTl9TuMtT0xv4Pm/8Ayjja+
         JcWdWGTZkHq4Z++lBJd0pYqN7LFXMWuCkiyz4y13A55A/krv6NfcRfHSsLPAEXMBGjxC
         7Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140986; x=1733745786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7TOWAjI6mgo3typHSgU/6g6JMqxt2KgeMAkh5f6OGU=;
        b=dBxu+B5m60/KD9xt39eGV4NQ5++X5Rxfky6vECFsxx2To6tWvqIUPgAfs7OYE4fwBm
         8SE1IRGvyQvzunMQqM5B5p51+/xh37MCAWK0P4IWS3/Vh5ajJ9WgVGUvTIO1bLHSvrwR
         a085SnzO6DAk2xS+hsOLp9OjdvUF2F9g2nEMRfnoIEdycnC5eBiIO4495FJIF7cmfr06
         IHSgBokCnW/YQjqjCEOwJNHKeLXTFk8PBqbSWUvpVEiSpygpYbnlB3WUtNJv2BdPaD/2
         g8hzv1LGX4AlXVGbuMl42NG/81TPkZ2o+c6T2gEDqGtxO+lujoq55qHeHqsrQakkUQFe
         LNkg==
X-Forwarded-Encrypted: i=1; AJvYcCVlBjrvQ5VdcEN+QASAm4yIab7PqTMyBnaUL2VsJYYPA+rLchYSDgJ0DqWdFWUBW3L5OVmL4MtJc48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOkcW1g++xAmzB7ESdQ2cZQnnR47cA3wM22uoiWTu6/fe/Z+16
	vWDfl+OISqTQ+hgjTL396TW7p321pfXvBldQz5HOvEXBxNnUSZXCLJ6uZYZ+u/E=
X-Gm-Gg: ASbGncub8eyUIJblXeGZvEkE05jSRRj4068/1Cn3wFG/Uk1KyQW9V6sS75FtEZtSmra
	Wc6l/hxAcdHCLGXXi+X8DaTaz681LK73pSsvpEaTtltQeRF4k8/OSOb3z5I3+c+5u9rspbFZHDj
	MKAFJdT0I/czINiFidwWOdrUoyaKePwdPy1aFgZxQEKF+3QY74J585AIsYzaG6hyBOWWIXJNsKg
	oc2tsDVwP0R1z0xUFtDeammylkMl8yK4665RJuj
X-Google-Smtp-Source: AGHT+IEblIdLaPCkPWIaBiUzUXooM1nm9pS8RLKm1Rnw6SlcAmQnVQ8kz2BvOTzozxeqidhfvRPTjw==
X-Received: by 2002:a05:600c:1f06:b0:431:2b66:44f7 with SMTP id 5b1f17b1804b1-434a9df7a8dmr222885245e9.31.1733140985417;
        Mon, 02 Dec 2024 04:03:05 -0800 (PST)
Received: from [127.0.1.1] ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm152396095e9.8.2024.12.02.04.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:03:05 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Dec 2024 13:02:30 +0100
Subject: [PATCH RESEND v7 14/17] ufs: core: add support for generating,
 importing and preparing keys
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-wrapped-keys-v7-14-67c3ca3f3282@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2597;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=vY4XQO43wfRW3xI/7uuZkDLPJhyrBjrY4cfeoG+PMz8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTaHWIEnk3YZilaM3RjOTRCNfoccxXCgiWgs21
 PjJLQo3KemJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ02h1gAKCRARpy6gFHHX
 cqWwD/9s/QIp9RedYoUmJr1mV39dwfCeiVoo/zmuH5/kRvjp3XhFzfg2DqWPpeeuZzf4R7gl4pa
 TGNNYvSnl0SfdPXR12dGxbYjuFmeOT87jjfu45B3lEI1Np4kftp7cteHHlfW+FxPN5KhvcblES7
 QxdHm2LrduuzMq0/FxM+hC9DpQt/+OXlvWsKWAlKSGMlQcipS1S3CMf5yD7Z1vDCL8NipDuYgCZ
 ttVGBqJFaSM5AWdLgyem1tjCDr3RPe6Vc1Un8Q9DaIoQU8S3oe6/c8asuBo/mUhCMeykG/D0Edi
 uVZActTVn61PZqT12d9/TmzqFi5l/MfPLYfm77QxR7kz/uN7OalyD4IoESTVgIXDmBOFpaE6eHq
 rCGy3veOw29fuN/M3FQnZJ7I7j/HR2ZNlLHIDdRuNXJjO7EUv3bHh3y+9ivDCUgP/5VadNva9Xn
 Z5msG0AiQLYeJP79rSFnBcyGtkZtoy/GIZje927jyU/40K+nCgN5O8VMIIgu4QNc3rr88zolZ6j
 T4NapWeYPWTFd/Adi4kGJWvbB+HTASJdsR6vQgA/iCQctW/qjmhY41Di1IdWa5RGS3QQPfl19cV
 jSN9v+ZDOJXkQpuBbWU4ZDxTX7sgO2MqUqTO7YMBZm1deTKc8QnTBCqzgkTdfjjsEQMm6JnQwlY
 OYJxCc9PqOLjdOw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

The block layer now allows storage controllers to implement the
operations for handling wrapped keys. We can now extend the UFS core to
also support them by reaching into the block layer. Add hooks
corresponding with the existing crypto operations lower on the stack.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 2530239d42afa..49c0784f2432d 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -145,10 +145,51 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
 	return true;
 }
 
+static int ufshcd_crypto_generate_key(struct blk_crypto_profile *profile,
+				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->generate_key)
+		return hba->vops->generate_key(hba, lt_key);
+
+	return -EOPNOTSUPP;
+}
+
+static int ufshcd_crypto_prepare_key(struct blk_crypto_profile *profile,
+				     const u8 *lt_key, size_t lt_key_size,
+				     u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->prepare_key)
+		return hba->vops->prepare_key(hba, lt_key, lt_key_size, eph_key);
+
+	return -EOPNOTSUPP;
+}
+
+static int ufshcd_crypto_import_key(struct blk_crypto_profile *profile,
+				    const u8 *imp_key, size_t imp_key_size,
+				    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->import_key)
+		return hba->vops->import_key(hba, imp_key, imp_key_size, lt_key);
+
+	return -EOPNOTSUPP;
+}
+
 static const struct blk_crypto_ll_ops ufshcd_crypto_ops = {
 	.keyslot_program	= ufshcd_crypto_keyslot_program,
 	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
 	.derive_sw_secret	= ufshcd_crypto_derive_sw_secret,
+	.generate_key		= ufshcd_crypto_generate_key,
+	.prepare_key		= ufshcd_crypto_prepare_key,
+	.import_key		= ufshcd_crypto_import_key,
 };
 
 static enum blk_crypto_mode_num

-- 
2.45.2


