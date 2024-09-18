Return-Path: <linux-mmc+bounces-3924-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C47297BA56
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Sep 2024 11:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F5CB237F5
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Sep 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31FE176FDF;
	Wed, 18 Sep 2024 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERkZmQIT"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEA6FCC
	for <linux-mmc@vger.kernel.org>; Wed, 18 Sep 2024 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653010; cv=none; b=TN50mZ7mMvpV9YblWAod/r7u8LqtxYTEq+cqPc2psiolz12AtMC5Jes1QQvWoyeuxZnul+w5rrtrZn2uo2593Uixx8ZJTeKuuhIGlo8ibF33jlDTjXjqCXuwGlqGda0yf0TrW/KSpdEFHYc/Sj+tbvGDG1cu6xeUrvqHqZ62eek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653010; c=relaxed/simple;
	bh=YB0Rvn3c1qKILtJp71dVoJxeEYo+qv7f0O8P/jepHW4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=QG9lxJT1CpD3nyrvyOmIf35nS4EuANUh4+YLN4qZBIkSWzsgKfkIsLu3xSMaDoNFlSoGUwMptFMmh7V00BeZPl/wiK23m7DCzV6DdmaYy4arhk45xglOiYrkAqychJ+iEOtcvbTURzKbsuw7uRmfOMY3GUeFVhJ+U9jTJ7M1D/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERkZmQIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D92C4CEC3;
	Wed, 18 Sep 2024 09:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726653009;
	bh=YB0Rvn3c1qKILtJp71dVoJxeEYo+qv7f0O8P/jepHW4=;
	h=From:Date:To:Subject:From;
	b=ERkZmQITc9Ua/gL7xI9UfhUcYRHnzjdRfRwXvAD3Tg0H21535zocNSMgP819YcKnZ
	 n+XGo70L37ijb+fYEjFEr0cyAWExORXUgWKA3A/hJMnZ32+GcJf6FWAep3Q4XbdnnT
	 vLzCLt4BoLOx9qMah6YzAuvthYyWmpk53ZgsjSsneT4xvzFJ4dHiVYNyAuPbatfEan
	 CXELSsPsp44HPxlBYqXpupuOWXiPr2ia1ZwvxuoIH2qOA7UNoVfNDUkFSFLpSY0TxY
	 k7aTURl4udJ5sm6RYm+QIh4+dK4ngPWOK4frApjIUF8TxWcKRF4XLdE1QrP0saKmm/
	 Taq6oLx8kcAXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EB83806655;
	Wed, 18 Sep 2024 09:50:12 +0000 (UTC)
From: Georg Gottleuber via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 18 Sep 2024 09:50:07 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
Subject: sdhci_pci module is blocking low power s0ix sleep with GL9767
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Georg Gottleuber added an attachment on Kernel.org Bugzilla:

Created attachment 306887
kernel.log s2idle without and with sdhci_pci module

S2idle sleep on TUXEDO InfinityBook Pro 14 Gen9 Intel laptop with GL9767 SD card reader consumes 6 watts. Intel Core Ultra 7 155H is not entering s0ix properly. If I blacklist sdhci_pci in /etc/modprobe.d/blacklist.conf then the device sleeps with 1.2 watts (this is not super good, but OK). Unfortunately unloading and reloading does not work either. Once the module has been loaded, the high power consumption remains, even after a rmmod.

I tested this behavior with linux mainline 6.11.0-rc7, 6.11.0-rc7-next-20240909. Kernel mmc/next does not work either.

I also used Intel S0ix Selftest Tool and it blamed the GL9767 SD card reader.

File: kernel.log (text/plain)
Size: 150.48 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=306887
---
kernel.log s2idle without and with sdhci_pci module

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


