Return-Path: <linux-mmc+bounces-4783-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A29D4351
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Nov 2024 22:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE477B28B35
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Nov 2024 21:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF711BD03C;
	Wed, 20 Nov 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjMjAp61"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEFB1BBBE0;
	Wed, 20 Nov 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136424; cv=none; b=oNsGSgxLrx5hO//GVnUsXgYmOisDTiIqW2GDjm8EzR8MPoohxbSbHOuMFbJCSeD1JWxNxXStWFpZQmSHlffgGnIEcx+WLe5jFwFV9J2zred80fUMvSBwgKg90+uoCOnOeAYxCz9vX8bWHvMMX+9zBF3Q0SbQY8umQIBSKrOxYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136424; c=relaxed/simple;
	bh=dkwHufzagrij+JgxU73Xm4sazl7KhJ5U9V/vqHm4S3w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YyOwLSHG/ZsXBC/rFGLfxi63+4SZrJfiOylSMgw/5HHluK4UmQnD4r5vBC/LeBDav2LWmHEHL6tPbaRzZBgXuha6uY3eycDE3InGG6Z0jfgGqPiNu9RPiBeZoYgwHhXXh/BdXV/UEH/9pfkZPIKjOQuzGqZdDeNvq3k75gg75B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjMjAp61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30926C4CECD;
	Wed, 20 Nov 2024 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732136424;
	bh=dkwHufzagrij+JgxU73Xm4sazl7KhJ5U9V/vqHm4S3w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JjMjAp61J9+6r0lZMHw2YFFOmPyCZiM1I3VB2XptWVQCv8xLAT/sr1A86CkSzrsgi
	 vmSQODaKqiw+X1ndfSW2KT8XbNlPvlOdBfB2uqi+xb0Br4NGR/DxLprkgAh2ydRJuz
	 wWKpa7MaCjXThKQIoA4lHWSq1mmuM/YFB/F8Wcz8tzvhuWjizkuyD2Cg5cKjN5slx4
	 FX7HM7TAbnTg4Vi/usxVWxmmxdfBVsFFJ15RR7Mj2rrh3aUS8M7tuekr+XHr4b1Qoc
	 7zHKmfT44a4iOnmGz1qNsHCqTsGIQOYhyGBWycGr6Sh+YzHhUI/gxxOy+mrITn5yin
	 OPjqT5Y6kJbNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE23809A80;
	Wed, 20 Nov 2024 21:00:37 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118132623.154217-1-ulf.hansson@linaro.org>
References: <20241118132623.154217-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118132623.154217-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13
X-PR-Tracked-Commit-Id: c0baf6ead75d6db16798ae48a4ac38c3af4e9280
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38556294b83f5c5818041c98a00e3a0e88fbb58c
Message-Id: <173213643569.1349251.15145682804495011762.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 21:00:35 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 14:26:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38556294b83f5c5818041c98a00e3a0e88fbb58c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

