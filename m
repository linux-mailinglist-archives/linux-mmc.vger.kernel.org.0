Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEA22957E
	for <lists+linux-mmc@lfdr.de>; Fri, 24 May 2019 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390156AbfEXKKc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 24 May 2019 06:10:32 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:39867 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389806AbfEXKKc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 May 2019 06:10:32 -0400
Received: by mail-lf1-f45.google.com with SMTP id f1so6691264lfl.6
        for <linux-mmc@vger.kernel.org>; Fri, 24 May 2019 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U7NqsxduTML6ThIFJ1X4Tao09DbCTx/kKKXM/580o5s=;
        b=g4/yUE4WonYVCbkWisUPSccD4AJiku3DsU0RiKPahQsT6OMSzbBpEj5OVfAT6vBFkn
         th6D2L8a965TkJ029h18S1Q47fEiVyKDuNSvAWldiw5q05urr60w4O5ELID8hVuqxWqI
         yJlLTMitbQPkOmv/gOkz6rN4f3jDvKdjU+GCBlyDNVPwdNm12F5NOoSr0fpeC2ybdJ2p
         m7/oO/5DYILVA7G0z3YcMDHHfzYHy3hC4/fgOONIvmgZfhLFfZXAaQgxUBd/gpTT6mNW
         GcDl+HNOloU1L+0U27+Fv1s0QD2Jr2ABykxVwMD2GHUhsGABkuXKeXvhqAKzZwnxTrZe
         7EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U7NqsxduTML6ThIFJ1X4Tao09DbCTx/kKKXM/580o5s=;
        b=GztnaDfxegjFg6wDCByF1hj2bGEJGChlEhUNnCrWUS0zSBLRQhQJAQXDhmo6VgzI4j
         ErM8cYMyRARrnnkExFbiYWemkyXtkBYGIQ59sRZIDiQlPm/FBDarj1FqG6xbH3dIN8IL
         nPTwipSKg3vjNd9jbaoWURxtIUTZ63q/VdkrqKdmtwSxekS+xz7Dp0DCja4C1XVf534+
         QXPtC1LMK7rw15ty9AcFDjtiIRVZJ3d4/AcrcShDCRmQIeqXS3Gw1fZrEDomj9G2rVNe
         Nmd1CkxRCpROe4l/Yno5i6VDtBVPytB2gl7yabq+U1sUb9d2SDEiazACaueWJrtq88cG
         p+RQ==
X-Gm-Message-State: APjAAAW06rhUT0r7cx8TNgKdXDPjawsqq7Y0suKTGhs48BP4IAXtmkVs
        0J865cPl1vHwVvHCS7A8aY4Hdw==
X-Google-Smtp-Source: APXvYqxvf6E0mCnGnszFgr+tBQ1HPjaojk79rtWJhiZQ13Faw3GR3gBLcdPftYjpFym3Vk0p27RqOA==
X-Received: by 2002:ac2:510e:: with SMTP id q14mr9879286lfb.135.1558692630306;
        Fri, 24 May 2019 03:10:30 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a10sm302945lfi.9.2019.05.24.03.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:10:29 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.2-rc2
Date:   Fri, 24 May 2019 12:10:28 +0200
Message-Id: <20190524101028.8158-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a few MMC fixes intended for v5.2-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5ac94332248ee017964ba368cdda4ce647e3aba7:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-05-14 20:56:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-2

for you to fetch changes up to ec0970e0a1b2c807c908d459641a9f9a1be3e130:

  mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem (2019-05-15 13:52:05 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-iproc: Fix HS50 data hold time problem for a few variants

----------------------------------------------------------------
Trac Hoang (2):
      mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time problem
      mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem

 drivers/mmc/host/sdhci-iproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
