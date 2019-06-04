Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085283415C
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfFDIO7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 04:14:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38492 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfFDIO6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 04:14:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so9895817pgl.5
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2019 01:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=e4QisK5dlRTGLzT7/Rg8a2odjBOSln7PHE3O27n2JN8=;
        b=trbg0frb5Fm6WDCdwfgr0zwTekzKj6RqswMPjQMJ99rO6iHuS2rMNYCBGuDZBGGJSL
         VXvzRWgev366dHO4Ju+XgTk8mr53kJtOrWff7OR0VQAnJN/emszpnUFXpteaSuwy+3RD
         6Qwkhht7EOwDAPmNItBNdWldGbu7b/081rTHGBXxhn6QNbTtdri4hBkShVXhnufArVvu
         iSA9g2TY1ReSSUCGk0krgRSecKARonkhd1Vixw60KDRizzeRGhnvZdMNjC2Kzv9Jwicj
         ujsONmhW4MXoIptsfzomXNoWz5qdGXjZlDUflQJBSlx/unwniaY+PBYp8Xh3aBF1cjOg
         0YAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=e4QisK5dlRTGLzT7/Rg8a2odjBOSln7PHE3O27n2JN8=;
        b=PkMU+27lIN2zY3AYB04jeh25eAuzPM2X9xAE63eUOwI4En7mCprlts3Yk26aKkW+sb
         1D29ZSRe3BoCYCtk3NBcRN+bglIME1jThqE7XrMLd2bLjJ2kBg/pLtT7k94dvGuIKdsI
         KOHwG4wyC4uudL6Es8Fw+lzi0S2qehp5e07s/WagxgAUn1rywW7wLGXXJoBKOL0XpT3F
         1b2NzHzIe7VVZGEL/rH7a9r9HLyxHNqdaysRCQfPRT1vtyAmeLwAZ9IP4SBRucnQ7X2o
         VXj2AHDEsuibGr/pt9c3fw8jbzG3kHzH0Xci2K9oo0gNALTt2I6Ebj7y9tHu1jMe4ylK
         4fPA==
X-Gm-Message-State: APjAAAVjaurzqvAmydVKXEfQbzX7C8MDsw90o3hBkrajZxjbNmAbFZ3R
        QBGpkRtl6Qri2zqsRPA2BQd5MG47uxJ9YQ==
X-Google-Smtp-Source: APXvYqw4qpyu9spV1elQpgXWUR1JDezR8zWgDrSzwYuh+hIyg/hAg3LaU9yU/tm5hbVZNcFXJ+fT0g==
X-Received: by 2002:a62:d149:: with SMTP id t9mr14481108pfl.173.1559636097966;
        Tue, 04 Jun 2019 01:14:57 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.14.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:14:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/9] dt-bindings: mmc: sprd: Add another optional clock documentation
Date:   Tue,  4 Jun 2019 16:14:22 +0800
Message-Id: <84abb6b282b1fbce0c39ebd2b42ca4c18118f863.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For some Spreadtrum platforms like SC9860 platform, we should enable another
gate clock '2x_enable' to make the SD host controller work well. Thus add
documentation for this optional clock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
index 45c9978..a285c77 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
@@ -14,6 +14,7 @@ Required properties:
 - clock-names: Should contain the following:
 	"sdio" - SDIO source clock (required)
 	"enable" - gate clock which used for enabling/disabling the device (required)
+	"2x_enable" - gate clock controlling the device for some special platforms (optional)
 
 Optional properties:
 - assigned-clocks: the same with "sdio" clock
-- 
1.7.9.5

