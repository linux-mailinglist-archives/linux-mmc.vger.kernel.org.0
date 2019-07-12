Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45D666383
	for <lists+linux-mmc@lfdr.de>; Fri, 12 Jul 2019 03:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfGLBzL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 11 Jul 2019 21:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbfGLBzL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Jul 2019 21:55:11 -0400
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562896510;
        bh=wqNztD3bLulHYz5kS19NfmBZeMIxm6hVQbILLa2cvDE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Es6m/3EARbjcXiDmLw8sFRebAsds7XjnyiSs3dQUpFAWcjCltMATdizwSxHa9dPXm
         t/iKPOE2OqMhpOIt22qQXDXv5q4G78xwo3/ial9W0crsNNVekIxvv8PVD2KTIYfDAT
         X7K+SfMaxtO2o0xQkdN5Yfw6aRTw284yXBALwhZY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190710140116.457-1-ulf.hansson@linaro.org>
References: <20190710140116.457-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190710140116.457-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3
X-PR-Tracked-Commit-Id: 59592cc1f5937ced72e11e681c3e358a0375f7ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8931084c0d017314ad025f19353f7c5c1d3782d8
Message-Id: <156289651021.2089.4252920419885286447.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jul 2019 01:55:10 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 16:01:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8931084c0d017314ad025f19353f7c5c1d3782d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
