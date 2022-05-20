Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9657552F2B4
	for <lists+linux-mmc@lfdr.de>; Fri, 20 May 2022 20:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352733AbiETSb0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 20 May 2022 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352688AbiETSbQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2022 14:31:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BFD17581;
        Fri, 20 May 2022 11:31:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so8508716pjf.5;
        Fri, 20 May 2022 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=cjt9E9fZMoXkG9/vtMWlRzcB3stg0Ntfb0ElsRksjaE=;
        b=qkXqaan3fQHT2kMs6+pch85xT5CjG74YwY7ew3wXgVesUBbkP182qTS5et3iyBCifM
         fQHuFDz9Zyoa6UteUVFmmDpEi/Nvxa/NZ9V2ImQNtAFZ9O+iP8Y4zj9jmZiEmt5cfVir
         sCERviag0Sip0TiCrrw8MFUMPZ0LIGmk4X535YXrCy2y+i2SOdunnj6ZGg5ZdG4N/XYO
         TsEqZw+b4UI64UbJuVsDVudHiibMbj72iY9AjKXUTtQ0Lc9fHbLQ0ahu6JtRi5QUrfj6
         H6lqZoUt+u0u429uObEOBYF+80XZb6ItgW3PZK1GUzP13ZgjtCcmEm80tRZiNdPSbeq9
         oLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cjt9E9fZMoXkG9/vtMWlRzcB3stg0Ntfb0ElsRksjaE=;
        b=WgOwdvpAf6GO6lZQUahW8mYIw2DSpKh6ovHYEC778e5ot+v7PDxGjlJMZUQl/Er1l0
         UaQXxPviQ3pXiXaRFq6+4ZSgzfPbetEqUfRDFL82zO4QR3oVKZ4atmBrzS0q0hLiioHX
         yadBwcB/YAJu/fjxy3EE1qceRB7PcMtBlQikqLWnleYvd0e1iIu6dDbZCr3Mg4K2D/qc
         2kqcb1KsyTPpmv6G7ie1NSBu4rL0PJ3KIyrw9Cngo74VmV4eRiOO/wbsUuGCAqfap6Lx
         hqxS3JTVGMpvfmp8cQWqbsXoPkkwyNaq2LiYPkzvZgaWbSBuwQd6s1jJMVHt7BzCwP0w
         E9YA==
X-Gm-Message-State: AOAM532q8YZ0SOv2l8f+rjyBMNLpYKgzZVuzdU+LgJl3QaFZMlMqbALq
        ZBVMoVa4NrlSxIW3GWotRS8=
X-Google-Smtp-Source: ABdhPJz1577/M5wA3DentQxDMc+iszhh3Sm7fQDkAsm15OapNGkCXrqfmtlUikxOstU//4Wx934Few==
X-Received: by 2002:a17:90b:3147:b0:1df:4a21:15c5 with SMTP id ip7-20020a17090b314700b001df4a2115c5mr12285859pjb.25.1653071475415;
        Fri, 20 May 2022 11:31:15 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b0016168e90f3fsm87476pla.5.2022.05.20.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:31:14 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v3 0/2] mmc: sdhci-brcmstb: Add support for optional sdio_freq clock
Date:   Fri, 20 May 2022 14:31:06 -0400
Message-Id: <20220520183108.47358-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

v3 changes:
- PATCH 1/2 v3
 - Based on review comments reverted to using the 'clock-frequency' field
   in sdhci-brcmstb controller node for the sdio_freq clock 
- PATCH 2/2 v3
  - use devm_clk_get_optional() to get sdio_freq clock
  - look for clock-frequency value if set in the sdhci-brcmstb dt node
  - Added pmops to unprepare, prepare sdio_freq clock on suspend/resume
    in addition to the sdhci_pltfm_suspend/resume()  

v2 changes :
- Added Reviewed-by tag to PATCH v2 1/2
- In PATCH v2 2/2 Used host->mmc->f_max instead of parsing the device
  tree again, /s/clock-frequency/max-frequency in commit message 

v1 Changes :
Sending the remaining 2 patches separately after implementing review comments
for the patches 3/4 and 4/4 as part of the following:
"mmc: sdhci-brcmstb: host controller clock enhancements"
https://lore.kernel.org/linux-arm-kernel/96fd3054-17b1-db42-9a44-a60485243807@linaro.org/t/
changes are rebased over
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git refs/heads/next

tested brcm,sdhci-brcmstb.yaml and driver with and without sdio_freq clock.


Kamal Dasu (2):
  dt-bindings: mmc: Add Broadcom optional sdio_freq clock
  mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 32 +++++++--
 drivers/mmc/host/sdhci-brcmstb.c              | 69 ++++++++++++++++++-
 2 files changed, 94 insertions(+), 7 deletions(-)

-- 
2.17.1

