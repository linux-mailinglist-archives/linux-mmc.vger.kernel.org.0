Return-Path: <linux-mmc+bounces-8384-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44295B4424F
	for <lists+linux-mmc@lfdr.de>; Thu,  4 Sep 2025 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA9167461
	for <lists+linux-mmc@lfdr.de>; Thu,  4 Sep 2025 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12B2F3627;
	Thu,  4 Sep 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BUzMEvRJ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04E2EBB92
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002211; cv=none; b=MdSakSo5dy721P3W7uAQNOgFpv5HhADyxeCPbEVjv8Esw9V7txBfphzQkaiwpElTvj6G1r/lLak17mMrUiznUOWJiU8V3yIKS7DhS2KWB4JiwlCkxNAOHwqvugUhjWgRguitHkgwJ9VnqNdTmVrkLGJtVSobgcwlxD3h063bjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002211; c=relaxed/simple;
	bh=PkmIbntlSSDbCIU3//pmB31oz3Tvb/BNxvNIJ97TuP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIzYX3XjW3+5GuhQUB2xW2312i1MO6QZ8iUeKPG4AARoFFThyiml1PfchRhnS0pIaoQm7cxRoJIX4vDrKGDEMMh+1yHrwKiw44z6MVq9yZfHXaxuO8w70IRuHXJ3uLItVYJpjiV6WiJPAj80N2kXct6TwORC5O1JT/Y9qLMdunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BUzMEvRJ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=zZOr
	5/vzHL2/W03R7cgpjsL8TTrFvZdllQGOy/p3JI8=; b=BUzMEvRJU+/xhCMHur2c
	1yN7qM3GQZTCT7DDlzbIBokkVtydOfccHuZ+fnaedZRVgFNyE5VjfgJ7kEiNCP8y
	jvf/fUfWNq9ZYbrUqI0jZlWuLmNnIGHN7F1Z1reRsv1ynFYZdmj1o8mTZwLRq1hD
	W4lYdIreDjhTfg3s5Gwhk3+uun3hVAgo6ZjDxzGLWfpfqC87LNQfONPZX+PTa4fX
	r/O8HaPWzFbUpKZei4l6gPOq7z7wMIKifkYMFgIZwWI2fQ1vfRb76e1LxRoL6jI5
	2K0FHleZqMVRAuV0eMMhC3fPQJXGvkGDPS5aHJaiumNKQpJsY5GJKy7F15j2THGa
	7A==
Received: (qmail 3728061 invoked from network); 4 Sep 2025 18:10:06 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Sep 2025 18:10:06 +0200
X-UD-Smtp-Session: l3s3148p1@hX9e9Ps9WNUujnuV
Date: Thu, 4 Sep 2025 18:10:06 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] mmc: sh_mmcif: Remove dummy PM resume callback
Message-ID: <aLm53kb0HWQK4mfe@ninjato>
References: <8b73e2071a1d87c8d09b8bb24fc35f371779c2f3.1757000061.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b73e2071a1d87c8d09b8bb24fc35f371779c2f3.1757000061.git.geert+renesas@glider.be>

On Thu, Sep 04, 2025 at 05:35:43PM +0200, Geert Uytterhoeven wrote:
> Unassigned system sleep callbacks were always treated the same as dummy
> callbacks that just return zero.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


