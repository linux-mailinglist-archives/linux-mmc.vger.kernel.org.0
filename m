Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A943EE1B3
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Aug 2021 02:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbhHQA4c (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Aug 2021 20:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbhHQA4I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 20:56:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E356C0612A9
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 17:55:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y7so30167516ljp.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 17:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u12rwXg8g4PJq/ZBmPuac8Qj8YYRwwb7Uj5T/LSY2zo=;
        b=EAAYpRI2iVZDTfCZlb3Xqro7/P2wtZ+jkRMZf1Bmh7AZuZINyv+zBfw/ockT4XoYLT
         QB/cN8F4orqXktrhSOfkliEEResJ0b5pqmxQ62pjSZViPa/GvUh+J3F3jdLlzCMrQQIM
         xHQTiw2dvd3RmKMMmpg1bP25EHiY+NSdxghJmhccESTLR3y+C9/fwa4EXqi7iu9nI/FP
         OCrg6JQtgfr5ilE4Qypv60EKDcw8RS1WESxnJs9KflYa6JFtcIzkXeVXPxktb31oRcch
         UteYQcWAA0Gb2cpQn7rQLebStwfVY9moW4BolAL9a3QqdepGzKAdBMrNAF0UC3z45+BR
         7PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u12rwXg8g4PJq/ZBmPuac8Qj8YYRwwb7Uj5T/LSY2zo=;
        b=LEDt/srEUnycgLBh0tDhfiPqyq3MeFhsDlf57Bi/+gj/QihctAeJB6qOoP0QQDVDkm
         jTq2/EbFHdag79NVcyxhCpOjJCryDC8S4P8B+WumzDvZs+T9g3cn67M7Ls0EH6eOGYFT
         9QvnenbS2aMIwGpnEjKAgQsGd5Fomxhp/FXGVN3DY/KMba2zJzeZZPjmYV85Nb5Z5LLp
         p3RExqaqMMKeFwxAsQYQVfnqq1W6ehltH8KwtIfRbcV9jUXOJK8aGJ51ScfENBu9MI8Z
         vsIPz3Kw3uNuwI3t3uhu9ceNKi5Bm+UbmuTlAckWlLzzSfyg9b602yIRewRWpWfnCMgW
         Ib5Q==
X-Gm-Message-State: AOAM531iQI3N0GxXzoi1nQFcwWlcWRWBcBCS2XzIRqftjl+SDireIUpV
        DxOSJfLJp+YwEo12d5dZe+uf+w==
X-Google-Smtp-Source: ABdhPJykxVR6EeoPt1Rvlafv3t+KywFGvitTYNxwTI9ilss5IuaqKndgqB3OhVtT7EruboGWfnj6lQ==
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr757286ljm.377.1629161723606;
        Mon, 16 Aug 2021 17:55:23 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z6sm40719lfb.251.2021.08.16.17.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 17:55:23 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [RFC PATCH 13/15] arm64: dts: qcom: sdm845-db845c: add second channel support to qca power sequencer
Date:   Tue, 17 Aug 2021 03:55:05 +0300
Message-Id: <20210817005507.1507580-14-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
References: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index c9b694e934d4..3025e5efd556 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -342,6 +342,12 @@ vreg_l21a_2p95: ldo21 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l23a_3p3: ldo23 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l24a_3p075: ldo24 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
@@ -637,6 +643,7 @@ &qca_pwrseq {
 	vddxo-supply = <&vreg_l7a_1p8>;
 	vddrfa-supply = <&vreg_l17a_1p3>;
 	vddch0-supply = <&vreg_l25a_3p3>;
+	vddch1-supply = <&vreg_l23a_3p3>;
 };
 
 &sdhc_2 {
-- 
2.30.2

