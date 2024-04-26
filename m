Return-Path: <linux-mmc+bounces-1980-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546FF8B40C9
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Apr 2024 22:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0912C1F22059
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Apr 2024 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF0E23754;
	Fri, 26 Apr 2024 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqgo1BdB"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B7224C9;
	Fri, 26 Apr 2024 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163104; cv=none; b=qtx3w82duGrSrjquQdtbrMi6ejLa1NuPKKEO+YdDMk6CIB0PKM+85UMca6fVNPtV7kNggU5cU8sJEuM/3qdPS+Gn3HJmVaSK167m8rajD43ijNOcKkJutptfElDrN7DvuyZi1bT4PqUZ+KABCIRr/q8u3BjeBVH3r/K3GgMxJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163104; c=relaxed/simple;
	bh=pnAMNW7iqQwFX52RhX5ZaqIXcfbcvNaz6xMxam6bOqw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n5dHNyCiFP+POYdBgkp82dz23G+lLC4B6x1a1+WpRqOJGo4r9iruH4cnC1UsC2CfBVugxYBOhhaIuZ0f2riX1SW1zY5TMCQHmznAmNp1tgSyHt5cBLIGkpR1ADZ6j4/u2N68kzGAvzwB5Rw5CVtdwQ702Ld2gMEFb8rv0SUf4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqgo1BdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A8F4C2BD11;
	Fri, 26 Apr 2024 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714163104;
	bh=pnAMNW7iqQwFX52RhX5ZaqIXcfbcvNaz6xMxam6bOqw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qqgo1BdB81XamqSUMd53spFPILaLxkyhku8j3CrhN4EKu43X8nNhE7swLF0uEwBux
	 yflEWlhtr2D8FusjNKjxO0MFv+qasYiPeYAASDFDuvuKZCWra4DBmC2WjyTbe62PcS
	 rPF/UjuZ9wpQ3ca68nAR+gHEg/OJJwnBPtOtqB+CeP42i4ibt+XRXaCAKpf1emM1h7
	 H6vMXV2W2i/pnFwv8594f6N1Q4cNL5MsRAMbLVxqnuZcdImWwBFOsQA8ePsPpY9s3z
	 z4VyFsESb4H/E8Pn7wq5fGGZ/3uN0ryaxOvpS53Yotm15aXU9JL17B8JqXY8gBPz8M
	 /GGtm/sAlDaPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C181C433F2;
	Fri, 26 Apr 2024 20:25:04 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240426195155.160462-1-ulf.hansson@linaro.org>
References: <20240426195155.160462-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240426195155.160462-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.9-rc2
X-PR-Tracked-Commit-Id: e027e72ecc1683e04f33aedf0196ad6c3278d309
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4630932a55298befbad62f2563f57bee16e0e450
Message-Id: <171416310416.19521.712556957067333938.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 20:25:04 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 21:51:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4630932a55298befbad62f2563f57bee16e0e450

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

