Return-Path: <linux-mmc+bounces-5252-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D037A1959C
	for <lists+linux-mmc@lfdr.de>; Wed, 22 Jan 2025 16:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD9F3A4A3C
	for <lists+linux-mmc@lfdr.de>; Wed, 22 Jan 2025 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C52139C8;
	Wed, 22 Jan 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9D+ZLw2"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A24C9F
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560723; cv=none; b=LgNtWgiZPAXsul8QgejT5OXOH+pAd0lvKTihCLhMNUYexK98q02RTKOq+F9R/boP9BlJvBIDsxkQnbneecHpIxgeWXXumhgKuNi8xiKAp9PPbmzXuQie/gdGRacNoRvcE/1xchaLiH/Y85acC49tB10beLPWujPLsHAgbwrwFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560723; c=relaxed/simple;
	bh=ICMpEvGaEwNCc0MLnb7wQ+8JxEStG713jxy/3bWdan0=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=dCKDHXvn3TJ8IzuzJ63blGnMcI25r+Oa4e/mi3kyTDjmAh81KXmz4gR+HJJRDqndFitE91woWO7Tomsclj09jKiETSiFI4NzdCeYkidVHCbWBVwjU2NXchYkH4d/TSdxsPwUwRQy5h4nZcekQzorCMU2vaB3DCx2QbuK2rK8cgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9D+ZLw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAFBC4CED3;
	Wed, 22 Jan 2025 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560723;
	bh=ICMpEvGaEwNCc0MLnb7wQ+8JxEStG713jxy/3bWdan0=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=D9D+ZLw2YVc8ETRw6CnjcLg18wRIhDzp91pvHEnvzmoalgRP9u/knM9OA33FN4sEU
	 GS/WwWaWxkSBFLQ1p58R8rpzyM4utZBNCdC8fhhkjEmpLaBLu+V0tkP1sgv+J3X6tz
	 3UihQQqSy6imhuQHCktDwHpKFUrjn5Us8CPnN6YdoY282y8kY9GMX1oVC8/7fafT+z
	 B2D5EGrIOjgGNA9m8yw5jIGkc2zWL0+D/cF4Ekh3LnaBw9y2txg34yDOrvLyPnA4bV
	 6AfMLVuEjXQQ/nJ16p5+9adm96s/eU0RPA594aI3+J2+dB0d2nIfc0+EnT4diYyTxS
	 wfUDXWBqV84YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F2E380AA62;
	Wed, 22 Jan 2025 15:45:49 +0000 (UTC)
From: Scott Brown via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:26 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c20-32012e04fc71@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Scott Brown writes via Kernel.org Bugzilla:

Same as above on kernel 5.9.8-100.fc32.x86_64.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c20
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


