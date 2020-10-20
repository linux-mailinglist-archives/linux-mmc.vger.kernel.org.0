Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23F9288FA3
	for <lists+linux-mmc@lfdr.de>; Fri,  9 Oct 2020 19:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbgJIRMq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 9 Oct 2020 13:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389944AbgJIRMn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Oct 2020 13:12:43 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.9-rc9 (final)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602263563;
        bh=wqVRVHfVBx8as7yckw4Vsnz7oI5aWIDQMZ5+lxCq2Is=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qiVbiCajvLKS0DIRD+7Vyn2UpZqkLlTuD2v23WyA7tzXd/Qe5R2353OplwF1BvB4x
         FsEszA4LuQ+K7PUWYs4VHSpgWm/LnWaZFvDCtJLje9B6Zt+GVaxRBAm3sE4zZYpcXH
         w0ZiJmg05Hc2ILjP0uapBucY/KaTLJAmJUAoIdyY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201009064600.335065-1-ulf.hansson@linaro.org>
References: <20201009064600.335065-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201009064600.335065-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-4
X-PR-Tracked-Commit-Id: 4243219141b67d7c2fdb2d8073c17c539b9263eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f318052ef2f07da2cd0c535d0d2900d5080a47e1
Message-Id: <160226356339.20000.13693655619234458614.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Oct 2020 17:12:43 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri,  9 Oct 2020 08:46:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f318052ef2f07da2cd0c535d0d2900d5080a47e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
