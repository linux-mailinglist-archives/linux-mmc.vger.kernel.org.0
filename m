Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7E014AA4B
	for <lists+linux-mmc@lfdr.de>; Mon, 27 Jan 2020 20:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgA0TPF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 27 Jan 2020 14:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgA0TPF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Jan 2020 14:15:05 -0500
Subject: Re: [GIT PULL] MMC updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580152504;
        bh=L03PiJEpErNCuhDX90wPqzrHj+NFIM48d0WCanFys/A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=endZGRM4G1oqZddTe/Zwz4u93XPqrMIA0nvVB/Yx3VzoNEjOPesAbD15jJHHaBkwn
         HLRlHySpB1jHO3XugDtAmm2sUPb873J0jTHoyUN9rjVBHWS24x/4nijRAFy0u9eFBA
         Q+cDfQ6wYt1x8FXttykIqQ3Oi46QkwkYJKNyA0EA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127111134.25963-1-ulf.hansson@linaro.org>
References: <20200127111134.25963-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127111134.25963-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6
X-PR-Tracked-Commit-Id: 533a6cfe08f96a7b5c65e06d20916d552c11b256
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e1af7567b266dc6c3c8fd434ea807b3206bfdc1
Message-Id: <158015250477.1024.11629338348137123497.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 19:15:04 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 12:11:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e1af7567b266dc6c3c8fd434ea807b3206bfdc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
