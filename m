Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BC73EE1CC
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Aug 2021 02:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhHQA5A (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Aug 2021 20:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhHQAz6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 20:55:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E074C0613A4
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 17:55:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y6so13343069lje.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OF+bSNrekE/+0wO+D2wfK4wViZM9bqH0gp92GYiunF8=;
        b=cM7uNQKuu5dnPNA/r3uzwOSlkZGPgMBXADPm8THNYFEDMOjOGxMvMjdB3F7ehvUI0P
         jSQA1m7WSHuioIu9NDWPO3OdHn8GAH0tzSEWc8j+mykFH4nrhKP5NzOx5cWlQkMdu0Dc
         RA2uWCHVYIgOAWJ6jR9xFlJUQMdSzdNHIHTvXNti55cFv1as17iQHUl5vsZK8TFY2K61
         exYI8oCWgFFX8pQABZBDMWguDSKljIB0UJPlHFiOj7SGwv6L2gJ6PL3xjWYwtE6FdD5K
         vCdq3wGKZ851VeJQtub1ZdI7Y9d9Uu8uVXKZNBQLtLYE08MNV9fV3CjZzD2ejwh6ZdDx
         m85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OF+bSNrekE/+0wO+D2wfK4wViZM9bqH0gp92GYiunF8=;
        b=pIkGImKXwFEDBw62WJzUiGGCJkLEqgunazRNPZY450t4NGGbUkt6VOK4bu4coArmU2
         L3A1K84DMnrQvEvbVIajMJcoDhtmb20ZSw2O5IqxElfxG6pyX/UFgX+3vlThB2WK8yxq
         W3GtEM556w4in/H4lA8YfKSmBWHy9JIVvc5RGiDUofcxgdHUJEQvlSMIdUHTe+vFME7U
         rC784SDj3gzYx3SALeZ75EgOOoDhRLc62XCHJVFZERoxGIPojsvU/NRA6XyPQw4isw20
         gUSvtvrXvl0um6ZFyDTrbV7qFaGoviPmMXA4OVprImEihkbVXugxc5X8bp/hZ0/7QHGh
         D9LQ==
X-Gm-Message-State: AOAM530fRISB8Z8ReKhYOMJ6L4CiAYuvuGqmu898R6y6So6IjFUrEYgO
        A5gPuMSsadiI5zELgd1C41FooQ==
X-Google-Smtp-Source: ABdhPJxJzCYv9Dq92ptE7pADX3DwMYSV+uy30xcy0SMHC/VUEZ9Cq33n8a04O6lvZVB3SkR+ZA4+Yw==
X-Received: by 2002:a05:651c:1507:: with SMTP id e7mr795429ljf.368.1629161722074;
        Mon, 16 Aug 2021 17:55:22 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z6sm40719lfb.251.2021.08.16.17.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 17:55:21 -0700 (PDT)
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
Subject: [RFC PATCH 11/15] arm64: dts: qcom: sdm845-db845c: switch bt+wifi to qca power sequencer
Date:   Tue, 17 Aug 2021 03:55:03 +0300
Message-Id: <20210817005507.1507580-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
References: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Switch sdm845-db845c device tree to use new power sequencer driver
rather than separate regulators.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 21 ++++++++++++++-------
 arch/arm64/boot/dts/qcom/sdm845.dtsi       |  6 ++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 2d5533dd4ec2..c9b694e934d4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -629,6 +629,16 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&qca_pwrseq {
+	status = "okay";
+
+	vddio-supply = <&vreg_s4a_1p8>;
+
+	vddxo-supply = <&vreg_l7a_1p8>;
+	vddrfa-supply = <&vreg_l17a_1p3>;
+	vddch0-supply = <&vreg_l25a_3p3>;
+};
+
 &sdhc_2 {
 	status = "okay";
 
@@ -916,10 +926,8 @@ &uart6 {
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
-		vddio-supply = <&vreg_s4a_1p8>;
-		vddxo-supply = <&vreg_l7a_1p8>;
-		vddrf-supply = <&vreg_l17a_1p3>;
-		vddch0-supply = <&vreg_l25a_3p3>;
+		bt-pwrseq = <&qca_pwrseq 1>;
+
 		max-speed = <3200000>;
 	};
 };
@@ -1036,9 +1044,8 @@ &wifi {
 	status = "okay";
 
 	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+
+	wifi-pwrseq = <&qca_pwrseq 0>;
 
 	qcom,snoc-host-cap-8bit-quirk;
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0a86fe71a66d..78e889b2c8dd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1051,6 +1051,12 @@ psci {
 		method = "smc";
 	};
 
+	qca_pwrseq: qca-pwrseq {
+		compatible = "qcom,wcn3990-pwrseq";
+		#pwrseq-cells = <1>;
+		status = "disabled";
+	};
+
 	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.30.2

