Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF5FD7C4
	for <lists+linux-mmc@lfdr.de>; Fri, 15 Nov 2019 09:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKOIM4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 Nov 2019 03:12:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35086 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOIM4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Nov 2019 03:12:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so9717777ljg.2
        for <linux-mmc@vger.kernel.org>; Fri, 15 Nov 2019 00:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0Lu//mayZU/5NBGVoU0YLJLr4UOFey7PELfDjgGamXw=;
        b=F+WUh27B46iCe7FcHeV4d1aCCxlBM/6wUo3AlSiE0xF52QZCnYRj70IB/xPc3bd4xJ
         91KfTchMRlaqWK7ht9wZ23b4pZKHtR9Xb2iUKn4rbPufek7YbPg9HD0gnSR/hA+ZXLaC
         HHy1oKEF11qMh4MtU3Mne4btFdrDGsOiwJqZ5fCCW8nFiqQojnXkgf9kpA7S6gojx61F
         fuBxF24AD31lVFq1xJsYbAtoYlIVdYMrdShZqR7ZVBQhwNyHTudZ2svPqjTWJ1PcKQk+
         9tohH85x/VZS0d6ZIqrHcrgVfBsGWETRt8BMTtbUOKrwbWoza69ByENpde6cmQm9y1xG
         vOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Lu//mayZU/5NBGVoU0YLJLr4UOFey7PELfDjgGamXw=;
        b=mtjRH9fCB64CckkHFlqLg/RrsULltysv8GD+Ni7jfstZI+Cl9JDf+MnCm7Ejm8AtaW
         m7bqSE9yzHS125ROf7lVwL6n4tnQpRzOP/n5MImHCKHB6aYR0FBK96TWsUUSvoDYfDbS
         BLGM1EEtIdEYsIGnVMpmAvihqnn9MLTRjmAkH+DIaaQM2aKrKtDET6ArR+UceSXwNAQx
         hrp3BTtSytyR/cN3I9R4RhyJci4rp6X95XEL0u9qLUSbkwrlbn2YuiUV3SvB4Ei9kgBR
         bOw8nAXRzHkNPtR9H96Uva9l9e2/BdqeqSkaEFPz2DPZiyV3Hc3iRdRo8N8DZ3m5bFbL
         KGEQ==
X-Gm-Message-State: APjAAAUAL2pcWVlsWRRxyhFRU8t/yDYgV2Zw7keq0TdT6DZL/ripjbLj
        igcAkHqZzNVNLLuNuuOzzntag3AOCFs=
X-Google-Smtp-Source: APXvYqyiv8GyvjaodcO+frJbS5JbpC1GtB9/bgc6kyn6rb2OCIYQpUoV0ipbrUQ7sQImCdm4+7x8fQ==
X-Received: by 2002:a2e:81c6:: with SMTP id s6mr10113994ljg.61.1573805574084;
        Fri, 15 Nov 2019 00:12:54 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a144sm5458482lfd.27.2019.11.15.00.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 00:12:53 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.4-rc8
Date:   Fri, 15 Nov 2019 09:12:52 +0100
Message-Id: <20191115081252.20154-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with one trivial MMC fix, intended for v5.4-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc7

for you to fetch changes up to fed23c5829ecab4ddc712d7b0046e59610ca3ba4:

  mmc: sdhci-of-at91: fix quirk2 overwrite (2019-11-14 14:57:53 +0100)

----------------------------------------------------------------
MMC host:
- sdhci-of-at91: Don't overwrite quirk flags

----------------------------------------------------------------
Eugen Hristev (1):
      mmc: sdhci-of-at91: fix quirk2 overwrite

 drivers/mmc/host/sdhci-of-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
