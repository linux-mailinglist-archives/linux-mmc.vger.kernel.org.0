Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2AD3035EE
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Jan 2021 06:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbhAZF4e (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Jan 2021 00:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbhAYSlx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Jan 2021 13:41:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E42F02074B;
        Mon, 25 Jan 2021 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611600033;
        bh=yKVzEkVKDl7uInjhgl+8i9Z04rJES7ElWiONfmMl4Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xez6CDhgp9rvpqTaTz3BUlc/FARK/r64iwY7iI6IEqyWlMMwNaTtjh9YcKA4aOTsM
         FOs7PIzPK+xhaqcPa0Zgc/ovm3gyeZAP0j4xzDAUAxoxVo4wTnLFhuhf7W8Ok+UAvS
         kQFCj0m+UrXBsw676VAv0VFZpJf67eJe6Jqc/OaKEvsxfWYDHz+JfhB0M0Fx9m1HvC
         ogLvg+tjYwIIkMiJRK0Go1bwC56Qk6PirUe/9ZG5WdC+cyGjJ3/SH7GdoI0bX+b02V
         uEDhIOy3E8vCUDBPqn+mIy+Q1Dl6A3vgpbUKHWW/q+ig3mnsK8IVMCzhf+5Yw5faQ4
         44OihUmMiMv5A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-mmc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neeraj Soni <neersoni@codeaurora.org>,
        Barani Muthukumaran <bmuthuku@codeaurora.org>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: [PATCH v6 6/9] firmware: qcom_scm: update comment for ICE-related functions
Date:   Mon, 25 Jan 2021 10:38:07 -0800
Message-Id: <20210125183810.198008-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125183810.198008-1-ebiggers@kernel.org>
References: <20210125183810.198008-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The SCM calls QCOM_SCM_ES_INVALIDATE_ICE_KEY and
QCOM_SCM_ES_CONFIG_SET_ICE_KEY are also needed for eMMC inline
encryption support, not just for UFS.  Update the comments accordingly.

Reviewed-by: Satya Tangirala <satyat@google.com>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/firmware/qcom_scm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 7be48c1bec96d..f57779fc7ee93 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -965,8 +965,11 @@ EXPORT_SYMBOL(qcom_scm_ice_available);
  * qcom_scm_ice_invalidate_key() - Invalidate an inline encryption key
  * @index: the keyslot to invalidate
  *
- * The UFSHCI standard defines a standard way to do this, but it doesn't work on
- * these SoCs; only this SCM call does.
+ * The UFSHCI and eMMC standards define a standard way to do this, but it
+ * doesn't work on these SoCs; only this SCM call does.
+ *
+ * It is assumed that the SoC has only one ICE instance being used, as this SCM
+ * call doesn't specify which ICE instance the keyslot belongs to.
  *
  * Return: 0 on success; -errno on failure.
  */
@@ -995,10 +998,13 @@ EXPORT_SYMBOL(qcom_scm_ice_invalidate_key);
  *		    units, e.g. 1 = 512 bytes, 8 = 4096 bytes, etc.
  *
  * Program a key into a keyslot of Qualcomm ICE (Inline Crypto Engine), where it
- * can then be used to encrypt/decrypt UFS I/O requests inline.
+ * can then be used to encrypt/decrypt UFS or eMMC I/O requests inline.
+ *
+ * The UFSHCI and eMMC standards define a standard way to do this, but it
+ * doesn't work on these SoCs; only this SCM call does.
  *
- * The UFSHCI standard defines a standard way to do this, but it doesn't work on
- * these SoCs; only this SCM call does.
+ * It is assumed that the SoC has only one ICE instance being used, as this SCM
+ * call doesn't specify which ICE instance the keyslot belongs to.
  *
  * Return: 0 on success; -errno on failure.
  */
-- 
2.30.0

