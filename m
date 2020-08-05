Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E63423D30E
	for <lists+linux-mmc@lfdr.de>; Wed,  5 Aug 2020 22:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHEUdY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 5 Aug 2020 16:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgHEUdL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Aug 2020 16:33:11 -0400
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596659590;
        bh=hohieLrBEZ90YkIm9xL36g8oXK2q87DzY/QCgBXMxQo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cBWJxehC8URIsh+ioKGWWb+1PevD8HxAwV303i0yMs6CAo/6WhcMTvayKFIy1YjTu
         ES1ordnbUe3/9aYuVubOq/Ls6cF25QxNLqgnUhNsQ+0Qr62eS2UVWxwXAgnauGnRDM
         4P2tAhQ2q9aOn9o/AQ6jTMpLr/FFmmbHLxITxd48=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200805073457.11906-1-ulf.hansson@linaro.org>
References: <20200805073457.11906-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200805073457.11906-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9
X-PR-Tracked-Commit-Id: 7f4bc2e8687ecea52177aac30fb153cc076f7022
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f7be6291529011a58856bf178f52ed5751c68ac
Message-Id: <159665959070.13939.7131494988698468540.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 20:33:10 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Wed,  5 Aug 2020 09:34:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f7be6291529011a58856bf178f52ed5751c68ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
