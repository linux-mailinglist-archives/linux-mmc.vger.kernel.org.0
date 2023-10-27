Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538B97D9C55
	for <lists+linux-mmc@lfdr.de>; Fri, 27 Oct 2023 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbjJ0O4q (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 27 Oct 2023 10:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346153AbjJ0O4p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Oct 2023 10:56:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158C0C4
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 07:56:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so19597525e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698418601; x=1699023401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rl/qZZlyNuKFPpmMKECLGKgxJaZVeJ33si5Kk5xurUU=;
        b=IJjCRp/LXnTUdpkwct0txO4/S6L7q+r2AFejPsm1ITrxEF3ciig2xUuToWKB7/ZXMh
         c2Tg+iZekMpkgqt+4rsQOcRyvbBP7Og1FGZvELASy97mYiymTjiJykfOGxMBnrJd6jJi
         xSeI6Xfz/nePm89N/yeH74tQc4ANG+u5TWHmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418601; x=1699023401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rl/qZZlyNuKFPpmMKECLGKgxJaZVeJ33si5Kk5xurUU=;
        b=dX23g9kuptHwdVvReRelRNyU6OOJiszL/+B6h9WEtb2XHnlY6qZHwqTeSWmxLrMuZ8
         RIdP8gB3w0Qg3XmIDhbajIVLzDv0LEE+Hw5WEsXhd1hVBXFURqQhACy2bWBjm0UmMWvW
         /EW7q9x8FUmXojSZcASWkCIbFJApNe6ecx/IZTMQIW2GVY04ayuNkXChSB0fqYFZAdKp
         FgyJF6yQEvYBNfLI8DtC1/7ZlaOK4zdXuSebErpZKFVKYniKX1t100neS9epwycVHBNW
         Ktq5Q9AKzNixJlAwXhAyRI0f9MKz4AZIQPb5N28G7/a5EfG83YsdRsMHSSy132iN7VYR
         +ebw==
X-Gm-Message-State: AOJu0YxwfTUftXNqg8Op6jmLj30CeAhR8W4HnmFJ0czVsnntCC7dkg9S
        HpqwRcZBFt5gJM4QUa5SjH2b/Q==
X-Google-Smtp-Source: AGHT+IHdKUMm1kAgh9vq8r9puyZE74TaNVLOYIk6vYukZWLMVmDacMEEco0qrP0kkfBXYFK2aPN1eg==
X-Received: by 2002:a05:600c:1d01:b0:405:29ba:9b5c with SMTP id l1-20020a05600c1d0100b0040529ba9b5cmr7142804wms.16.1698418601116;
        Fri, 27 Oct 2023 07:56:41 -0700 (PDT)
Received: from orzel1.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040472ad9a3dsm1815368wmq.14.2023.10.27.07.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:56:40 -0700 (PDT)
From:   =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
Subject: [PATCH 0/2] mmc: cqhci: Spurious TCN fix
Date:   Fri, 27 Oct 2023 14:56:08 +0000
Message-ID: <20231027145623.2258723-1-korneld@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

This series contains a fix for the "spurious TCN" issue that happens
during CQE recovery. We discussed this problem in the:
"[PATCH] mmc: cqhci: Be more verbose in error irq handler" thread.
The fix implemented in the form of a quirk, that is applied to the JSL
controller only. This was done this way, since I believe that this is a
hardware issue. Note that this quirk might be applicable to controllers
on other Intel SoCs too.
Please let me know what do you think.

Regards,
Kornel

Kornel Dulęba (2):
  mmc: cqhci: Add a quirk to clear stale TC
  mmc: sdhci-pci: Enable the clear stale TC quirk on JSL

 drivers/mmc/host/cqhci-core.c     | 42 +++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h          |  1 +
 drivers/mmc/host/sdhci-pci-core.c |  6 +++++
 3 files changed, 49 insertions(+)

-- 
2.42.0.820.g83a721a137-goog

