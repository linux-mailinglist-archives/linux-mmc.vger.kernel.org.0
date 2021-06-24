Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BED3B348E
	for <lists+linux-mmc@lfdr.de>; Thu, 24 Jun 2021 19:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFXRUp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 24 Jun 2021 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFXRUo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 13:20:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A0C061760
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 10:18:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m17so3298696plx.7
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWNwGk9GjelPq0lKH2dxtU8MIJBYkaGELFI1ssqXZTY=;
        b=axtIMnpDVdkjRLH4nX+f7Hd/a94NGXarbbRZp9pKXtT6TpJu7knFwnxzm/B9XB9U5q
         ADPy7uRDHNfp2pRHlI7Plj6WxokjAj3ZwsFS7vr4aASPUFiyzw/o62bdKWis8u+5oBW4
         Vikei2WzAFO6FSuuPDtR+qxX1leJS0yoWKXB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWNwGk9GjelPq0lKH2dxtU8MIJBYkaGELFI1ssqXZTY=;
        b=HZ8ynKmxkkBEvLQy+LC4Uz2l1dxf9F4U3qgNfw/QHfIarH3FezWf7NbKN6DmIXHws4
         EuX3L0mqP/A+lYV5v6MwSXD4aQQMfMl+Vefcui0OGmi4aNoGCJgICeP40tvpqdpww+O2
         gg8J9wLaCCpBLpSQWHdjEeoruOj3gMWmljJ+Md2g2DYO97w/KvPJ2EgwlcLE+KzOR8bv
         gsMiGKE4h7vdPpqmazI8pudD2FO6b+U/gsTTsVy4jR2DOzZ4VLUHxniMyaVzqDNomxMf
         LmidI6ZIE+1XTETA7urtQfm90vte/hHgLcvQlLsRN3AfRZRl1u546+cJLw06LOJCJS1x
         ZrLA==
X-Gm-Message-State: AOAM531iPoI74ckvtpSTn2fORd03I29JwZkjSWaxbzaq3c+uAGTifmaD
        nEI6Xzs/x1NOUuW+pgC6HtYURw==
X-Google-Smtp-Source: ABdhPJyDDZAEVmImuYqq+gOLGeBE++WkFuVJuSBHo1MrycS/xGTXZy6Yo8US/jLhBHewMabX0cuR6g==
X-Received: by 2002:a17:90b:4d8d:: with SMTP id oj13mr6232430pjb.184.1624555104750;
        Thu, 24 Jun 2021 10:18:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:fd74:62bc:19e3:a43b])
        by smtp.gmail.com with ESMTPSA id z9sm3365960pfa.2.2021.06.24.10.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:18:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, bhelgaas@google.com
Cc:     john.garry@huawei.com, robdclark@chromium.org,
        quic_c_gdjako@quicinc.com, saravanak@google.com,
        rajatja@google.com, saiprakash.ranjan@codeaurora.org,
        vbadigan@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        joel@joelfernandes.org, Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
Date:   Thu, 24 Jun 2021 10:17:56 -0700
Message-Id: <20210624171759.4125094-1-dianders@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


The goal of this patch series is to get better SD/MMC performance on
Qualcomm eMMC controllers and in generally nudge us forward on the
path of allowing some devices to be in strict mode and others to be in
non-strict mode. This patch series doesn't save the world but
hopefully at least moves us in the right direction while accomplishing
something useful. Specifically:
- No attempt is made to touch the PCI subsystem or cleanup the way
  that it requests strict vs. non-strict.
- No fully generic mechanism is come up with that makes it super easy
  for everyone to be in non-strict mode.

This patch conflicts with a few other patch series that are in
flight. I've tried to call them out "after the cut" in patches. I
assume other in flight patches will land before this one, so I'd
expect to send a rebased version when that happens, assuming that this
series isn't NAKed into the ground.

Changes in v2:
- No longer based on changes adding strictness to "struct device"
- Updated kernel-parameters docs.
- Patch moving check for strictness in arm-smmu new for v2.
- Now accomplish the goal by putting rules in the IOMMU driver.
- Reworded commit message to clarify things pointed out by Greg.

Douglas Anderson (3):
  iommu: Add per-domain strictness and combine with the global default
  iommu/arm-smmu: Check for strictness after calling
    impl->init_context()
  mmc: sdhci-msm: Request non-strict IOMMU mode

 .../admin-guide/kernel-parameters.txt         |  5 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    | 19 ++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  6 +--
 drivers/iommu/iommu.c                         | 43 +++++++++++++++----
 include/linux/iommu.h                         |  7 +++
 5 files changed, 67 insertions(+), 13 deletions(-)

-- 
2.32.0.93.g670b81a890-goog

