Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304F91B2AA
	for <lists+linux-mmc@lfdr.de>; Mon, 13 May 2019 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfEMJQC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 May 2019 05:16:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54946 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbfEMJQB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2019 05:16:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so7211900wml.4
        for <linux-mmc@vger.kernel.org>; Mon, 13 May 2019 02:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uv+6NV0EmUQP0o5PRDrka5VQ1Yz7shhQm+scRcHDJZs=;
        b=PrHEdLQWGkg3wCKaKVYVhqAgvxPN8AddD8F95eEsou9MkjYYCZfe8HTRgUxYpGYN2b
         dr6F8D0T0TVej18Ri4Aks12ZaF8HmNTi7cThd35lyB2PszuStakgUBYBcK9h8s31i4xv
         mqqnjpunSO9yctBrY5DWzTRaQigPMcCpEO0FkZ8Wb09WV31zf3E43Mi/N31I8XGJZsX1
         //dhG1QQ4C42WTEthDahd1KJkSixjCpmq0cBCYZQs/sufY6iHsiQNYHCsXha//f4zguq
         L420INpGoj9ekK6sGWNwonoow3OXe00RfTqx9KMS7TJVnYhYwMlm8OXI1Al61wWvXvlw
         dQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uv+6NV0EmUQP0o5PRDrka5VQ1Yz7shhQm+scRcHDJZs=;
        b=RWk/xlSboSnJpmHW2u0qeegoQcnm37vxV9Wkr3R4F8VCdG0KSu0A7IM3AVp4opfud6
         pssBBtcHBjB1nmsG4Ch8RWczv+WHtS72/TeOkDRYawJ/Jtptvo9fUcoJQKGlDyHKYaTT
         VlZDLWZMWUgEvq4htOgwx2n6XIrJYbzWQ3U25bBZCsoC8vISMg209sr95ozB2Zw671jk
         yvvJzVhCSmGp/xWnKZb10tlStLtDey5cfbLDwrFkTVINKt8tvXQhi9/C94YFUyF6ceup
         NrVcLBn5v35IfY61higyeFDkHuGAafGsj8GfLlEZhu9nanV8y/sf1S7c0PF2CejTSUX8
         G69g==
X-Gm-Message-State: APjAAAUjzBCAFKcVoqkcznSdGgGIjjLUzCcIfcIosmJsM+zC/DMfrfGz
        LN2NphkbxERXfPZp9HJX9+gJ/g==
X-Google-Smtp-Source: APXvYqwuNjtpZ5nXSONgqhfVluLzVKMVlAKJH+3lkBCN5WTnF8r/Y/p4FvW752dLN2C/gZJVrKB3uw==
X-Received: by 2002:a1c:d181:: with SMTP id i123mr15521449wmg.33.1557738959761;
        Mon, 13 May 2019 02:15:59 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g10sm10795091wrq.2.2019.05.13.02.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 02:15:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: mmc: meson-gx: add ddr-access-quirk property
Date:   Mon, 13 May 2019 11:15:46 +0200
Message-Id: <20190513091548.16674-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513091548.16674-1-narmstrong@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On the Amlogic G12A SoC family, (only) the SDIO controller has a bug which
makes any DDR access from the MMC controller fail.

Add the amlogic,ddr-access-quirk property so signal this particular
controller has this bug and needs a quirk to work properly.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
index 13e70409e8ac..f8914dab06c6 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
@@ -22,6 +22,10 @@ Required properties:
   clock rate requested by the MMC core.
 - resets     : phandle of the internal reset line
 
+Optional properties:
+- amlogic,ddr-access-quirk: set when HW cannot access the DDR memory, like on
+  the G12A SDIO controller.
+
 Example:
 
 	sd_emmc_a: mmc@70000 {
-- 
2.21.0

