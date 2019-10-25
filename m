Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6997AE54AF
	for <lists+linux-mmc@lfdr.de>; Fri, 25 Oct 2019 21:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfJYTzG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 25 Oct 2019 15:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfJYTzG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Oct 2019 15:55:06 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572033305;
        bh=aSnhvqlC7uURCGPv0iPE8pVfhkVBm6MUTMu2GdzWWEc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u1X5I9GipYQU4YeAeLluBm+A8x5AM5ZZteXPq99v+aZYbWSNi7lgpAgBXoiMJZ4/4
         yEzziSPmX/HbQYMsCgQLDxB+5uFp92gveqqkjaK/ZeNf8iWSkm55mLjEEmohMp07QQ
         1aEqXB7siqFvzugqfaYkMED4RLzTEe6wTceiWZ5s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191025140058.10668-1-ulf.hansson@linaro.org>
References: <20191025140058.10668-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191025140058.10668-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc4
X-PR-Tracked-Commit-Id: 2bb9f7566ba7ab3c2154964461e37b52cdc6b91b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f64928480f7e4183688d2f9c6f8ae5834925b966
Message-Id: <157203330562.840.17083029643098251235.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Oct 2019 19:55:05 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 25 Oct 2019 16:00:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f64928480f7e4183688d2f9c6f8ae5834925b966

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
