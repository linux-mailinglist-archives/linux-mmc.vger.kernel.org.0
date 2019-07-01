Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99681B2A4
	for <lists+linux-mmc@lfdr.de>; Mon, 13 May 2019 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfEMJQE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 May 2019 05:16:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37795 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfEMJQD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2019 05:16:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id e15so1942234wrs.4
        for <linux-mmc@vger.kernel.org>; Mon, 13 May 2019 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6faxotKxNMmgIEg0wYpwPSJedZIS/jOCkKVr0/VGHk=;
        b=JKM4PKuCaOCDQfqA2xTNlavdxZlkF6bf304MnUe0AK98cMu+YsZwoEHHU6Gyb4MCxh
         MyV/8q/FLiltE2V7/QmvqWD58wtNQAi+MqKau9cxNs++gp9kk1lZtKX7elvt6+hoaPQi
         iHAkXMaBlqmE8VwHd2IZ6vow0QMtJhXvZ22yyMTBkiOhlve1+7YgopfkXZVtQrZoj4UG
         g9qc0sgf/IZHiXDEqz0avtcAFw43pGN79pIHdntZZs4J1KR05bmJ187h2JCToaUhzoyF
         M3vl4pLd8Jsmn+ai1iKRftj9doEFEuxccpB0Gi5WM/PxHAGdHmkzC7cct+Cat/P1EpKo
         jOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6faxotKxNMmgIEg0wYpwPSJedZIS/jOCkKVr0/VGHk=;
        b=GbiEqmFLDE8XSk0AzPpvRh5HPjrOhIH5n9bpM40OIuy74uP7Ek+3bwgY0yTLzXp0Yc
         ekmiqsJrY+YG8x5nNFpta6ocVg6aMpHmYkzAxiJ0WEubGLDeyQc0OAoirvnfp91wSZFe
         cbD5hQD5HURV5Rmhtrj1sgtCc0IMI12nVUWRH5Shz/HpgixV7ZLWLgwwVqPN0u9TGD/6
         jLu+1NDeXqBHzIdNlrUKFCuRqDnoc6n1KF1WqoXmWaNeyqttZD8DUAHr8NNoZ5E/zSw5
         oUvMO10G3W/wt8wRPjUOOUdzvp0cON+RTyeIdtDUQBYIOWVqLdeasXoNh2agGQ8DrK5j
         HF6A==
X-Gm-Message-State: APjAAAUWbNufaosYbBJAJATZ45mRLGqoH3++KZDPZeRvc5/NsyPY56Gw
        2K7Bm/a45gR7G6jUHhYH5UB8Hw==
X-Google-Smtp-Source: APXvYqzC09Q1cp1hmohfvhqGnWmyH+vzmsbzRdbFtc8M6lKAhRHTZLjSeXHo1+LmemD8Qh/4HPS08Q==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr5102548wru.17.1557738962449;
        Mon, 13 May 2019 02:16:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g10sm10795091wrq.2.2019.05.13.02.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 02:16:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson-g12a: add ddr-access-quirk property to SDIO controller
Date:   Mon, 13 May 2019 11:15:48 +0200
Message-Id: <20190513091548.16674-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513091548.16674-1-narmstrong@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
mark this specific controller with the amlogic,ddr-access-quirk property.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
 1 file changed, 1 insertion(+)

Kevin, the MMC node hasn't been sent yet, when the quirk bindings is
accepted, we will directly send the MMC modes with this property.

Nei

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 5cbfca00f5cf..d8b3441f0c45 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -1061,6 +1061,7 @@
 				 <&clkc CLKID_FCLK_DIV2>;
 			clock-names = "core", "clkin0", "clkin1";
 			resets = <&reset RESET_SD_EMMC_A>;
+			amlogic,ddr-access-quirk;
 		};
 
 		sd_emmc_b: sd@ffe05000 {
-- 
2.21.0

