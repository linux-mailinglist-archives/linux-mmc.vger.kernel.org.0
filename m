Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B20A25812F
	for <lists+linux-mmc@lfdr.de>; Mon, 31 Aug 2020 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgHaSgd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 31 Aug 2020 14:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgHaSgc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 31 Aug 2020 14:36:32 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898992;
        bh=5aeOju9j4IfDj48BFvITJWdHdK/+gEN8/SvHJCDUu8E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B8Oj1Ds5wmHVyFbTFarxpsPZ/2bi+MW8qNmKDNSVWKKs3A+LaZnv0PFvzeELZPAxL
         veMOFYS3JXUxLTI5ZsAwe3anBBMwLW3QK3zGsg8EbDG9NR2ZuvHOssRE+aoaGoPizc
         zb7tdjgpuZP+hd9xpD9FuSXGrQg3GYig2Tf0PD6g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200831111141.19238-1-ulf.hansson@linaro.org>
References: <20200831111141.19238-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200831111141.19238-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc1
X-PR-Tracked-Commit-Id: 8048822bac01936fda2c7b924a52131da81e6198
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59815d6d1c773f3609ef9da50881a47e9cba9c25
Message-Id: <159889899202.18671.10653981266877417578.pr-tracker-bot@kernel.org>
Date:   Mon, 31 Aug 2020 18:36:32 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon, 31 Aug 2020 13:11:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59815d6d1c773f3609ef9da50881a47e9cba9c25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
