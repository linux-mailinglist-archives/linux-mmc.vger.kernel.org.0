Return-Path: <linux-mmc+bounces-6693-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7950FAC18CF
	for <lists+linux-mmc@lfdr.de>; Fri, 23 May 2025 02:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B577E1B61B02
	for <lists+linux-mmc@lfdr.de>; Fri, 23 May 2025 00:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4424DD17;
	Thu, 22 May 2025 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh8zaAiu"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF624DCF6;
	Thu, 22 May 2025 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958292; cv=none; b=jw08a5+3Pmi3VwkNAKPLqrtACHeNvNfV1Peri4ubWPPBSKnuP9EE3ouTsxwDn3mWyoYjQH8VRBLM1W8dVFZvRcgnKuFOam6gkqyN5+PvIKdrAH2RZlz9anCNvLdkRHAT4texbVm9Wy9/W9gDS9Tcfj4stRxXxpWUn/oECI/aVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958292; c=relaxed/simple;
	bh=a+PJbgyebW2jT0wb8nOla1Eu0pwI/vwcBwihJVZUOOY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bkb1RdpDxOgq8fLLVvTXkooG7CHT+AcE8PJMkMT8S+HmCpFZ1P45KkxlaCUKQmCyKvwkyTcLjh4MAtVZ+BARV1gsYvBtF98nQ5cZkzmKVA79z+mbO122XFEdnsBgpU75uWQtLXl8aIjXmbufxnjdZc0JnY8F1L4bMHYRc3lq7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh8zaAiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166B8C4CEE4;
	Thu, 22 May 2025 23:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747958292;
	bh=a+PJbgyebW2jT0wb8nOla1Eu0pwI/vwcBwihJVZUOOY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gh8zaAiuLXGVbmVS/qBFDHNjWGQPo41gkpmlw+t4K7PRNDdtmX3DJZZyAs8KR5rw1
	 fCKdDL9+sNMqjJHPUBLRTrkZ6k7dLQjwBbsPTZqa34WZ4m/4KoJ1yrxoz2D2HHODSJ
	 WpjdwrNCLiyMARQX++O8SzSyYjqORi0FqX80pQvsWguGQGv67jxQiRNAz7b6fGnjYq
	 vv48hPfz00RfRBeh/hyXT7VB6Ypsdu5Jfgi+QuOFTUPeuqxxZAjdthACH0WgNabuz5
	 pIi97t4R3aDgCEQWfs18bjm8Tthaye+myk4pH6cNo8o5i14uTD6A3nBwoZjj+iQK5p
	 CrJGu+HOg7i9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3903805D89;
	Thu, 22 May 2025 23:58:48 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.15-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250522214546.168524-1-ulf.hansson@linaro.org>
References: <20250522214546.168524-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250522214546.168524-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.15-rc6
X-PR-Tracked-Commit-Id: 71c9475b1e2cc4d31370b1b7a328bdfeea5d53b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5b2c67af75bc53008b17525b044affde136ae49
Message-Id: <174795832719.3061927.11599036436109239122.pr-tracker-bot@kernel.org>
Date: Thu, 22 May 2025 23:58:47 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 May 2025 23:45:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5b2c67af75bc53008b17525b044affde136ae49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

