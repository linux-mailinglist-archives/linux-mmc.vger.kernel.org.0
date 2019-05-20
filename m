Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB50230FE
	for <lists+linux-mmc@lfdr.de>; Mon, 20 May 2019 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfETKMd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 May 2019 06:12:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41893 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732334AbfETKMc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2019 06:12:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so6569150pgp.8
        for <linux-mmc@vger.kernel.org>; Mon, 20 May 2019 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=e4QisK5dlRTGLzT7/Rg8a2odjBOSln7PHE3O27n2JN8=;
        b=TwF5AsO5zpsHXKDVSh6tLAWFsy5YsMSB+N+B8/kqQ1zchDjm9CqFwdP5lcVriNwKE2
         Z8h+rqxbhmbhKy67tOYP6XzYzp3Q25nrcuXw4uBwDDdNAb8CkwdIjmte5MoAnoM+RkDB
         8mVUKrOOgzaOeS8aYkgHgTetDi8Sagwsh1irm28lnaydlZNXkVXRq87vrqLRA70YmgHs
         4uJCYf1w5y1rMiPLHxs/00M56zU0FWvbAWb72CfmMXcCU7uR1yoYXfm+ekppfHyL0A/7
         2OEFUWA+gsM5aC+gfH/J/99QDee8CBtIQj+NE3StWzhdJVOLYdFu1owAhp+A830cjBYh
         mcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=e4QisK5dlRTGLzT7/Rg8a2odjBOSln7PHE3O27n2JN8=;
        b=VQFq5OLIUWvkYtQX42D8TTh1cvzWFUcxFPngQLNQehI/y4aXVAqZdvTU2WhZ9mHuvd
         1NFUFFD2eKgz3xzJnNGFr5mFaDCJLj7v6U+NzMjtw9Mv+gl4PNydnGUSJXsOQy+STY0M
         vY2KvnrexrXN20cLTQmVUxdDYsjCdiKD0ic4sOR3BlKrdy77zDIMoCL1lOioT8fKWi+Q
         9oDIpJLPxeoXyCIIPpx6vNqM5m7JxTYMvF9OFBfBk/HiP4MXCfuvWSAf6ksRJDJLfRLd
         kj9bOiABtjU+n2S98XdzfDBX94N4HqfcXSjfh0D6M4WETIV6n95XVa5UhlxWUFpj4z0Z
         iT9A==
X-Gm-Message-State: APjAAAUzixYmS/9mRv60aD+nRtaFl4tacZUjQix4z7KaR2gCis25D2Ne
        +IDF1FHwWVoIl1n9qJ6zpgWWTA==
X-Google-Smtp-Source: APXvYqwcAZDdcUPPLz7jaZHV8PzDymn8O/Vo0pRi78sKNC1rTBbmH5DNKY7ezKJmPTZOMLYnygiLyA==
X-Received: by 2002:aa7:9577:: with SMTP id x23mr78981496pfq.164.1558347151948;
        Mon, 20 May 2019 03:12:31 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:12:31 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/9] dt-bindings: mmc: sprd: Add another optional clock documentation
Date:   Mon, 20 May 2019 18:11:55 +0800
Message-Id: <ee4ad0e7e131e4d639dbf6bd25ad93726648ce1c.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
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

