Return-Path: <linux-mmc+bounces-3679-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C62969DCE
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2024 14:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1591C233CC
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2024 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEF31D86CD;
	Tue,  3 Sep 2024 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vect8TnW"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625642101BC
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367093; cv=none; b=ptSSxuBw5lih3Wqt3D8Gvxdl3Z4hvT2gdr/i6ypVL/WXUPZ/+BMe/UJBLgXRggVnA2B08l2fBy+cB/2IVOcS1cjoC3lQcRTFa+GIjc2pCdW/pwLYQsRyWGKCaQPjOWtgeQossHXVSR/BXrHJSKdSR8osHufQlRASuR68TJ7DB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367093; c=relaxed/simple;
	bh=8bcjz7Guh52Axz9nJOwQxROCirWukCUGoHqIdK15WZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkmYlQi/0aNV96qizcUItM1yO3bJKwFHTGlM2l7Kv0VFe9nDUiEuBMD9vGLLamgXJiJN+Q7ex+vUq7YF8uxphDkC6LFW4nU7M6BwNTiLqBn1d9J1bqtBww+kPrdplOE50ESNCFtZ01hbm9gW7QCQ89M9cq6a5uNK5B9JDh2PYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vect8TnW; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1651f48c31so5456427276.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2024 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367091; x=1725971891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1nuruAFvQc61s51X1Lt2ynIqtOiGDBJmKVvebKTz6SQ=;
        b=Vect8TnWTweL9I3WUK81MIuartiLmzrAfHgR4eaUMyKRcd0i4WzFHZZH/xjbQV+7XR
         1q4P20TNzbBkW91x1xsr1JlORTzBk+64eSGsrCAmuSJWyoWZhBjFfyyCl5rvRGXKwPJM
         HplgXxs6+6nDmZXRnhPzYbpdI1u9rnD4IyMofZCY+lBSbA7W85paTSpd/tW52j5lyygS
         dLZYk4vBzcxciREdhJIJjEDEsYYTM0ULWHCOjYcSQO9fD4u9JBtt+xFGycyY/dWhlg+d
         Kn6kodeq44SwMzDlayNjo9LzugEXC1RDo/Bo5+0qcaHzBiKzhfKwY+muOfEOQkJilQgW
         E7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367091; x=1725971891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nuruAFvQc61s51X1Lt2ynIqtOiGDBJmKVvebKTz6SQ=;
        b=tvx+yTQ3zXw9zRvJR5b0pvlzVVtCyiP6hZRjJgHdHWU8roxtCZZeLOQzKDq36Tnj0k
         Lhrxg9nvltpaqvnjW+wnHvToB9VtoA5xcvHPDnuTboA+GMSLRgWahL5PKMM/shbk/yni
         x+i+9LuNiiIay+O4VXhSPsIUkkGqvvkw5nG+5lKTNWdhlJLI5mj44qL4xPf3VGqAa6Jk
         4ho54KzCgUOQZdkzS182RyqE+odzORJn2m/tM4QOcg9/Rh+c+VQQVD/djO5XeW3Esc7E
         dHqR7l3G1U1emKiyQ0YZ2kNfpFXZZUqOghzTqLobzdlJzqSJYQEmfLjmK/Jb3sgxLpt+
         beQA==
X-Forwarded-Encrypted: i=1; AJvYcCXAiEnpTra4RpTZ004VlDgZf2gd9kb3hxEgJ8fnPPgGCwxDALe3zfWmwizCNlhhCStRQzindkMk9B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxdxQfvYc72SY8ty52MFV2S21V/yufjXMz4j1HTSLGn7gLLH3
	WlmuixxV8bFXBosGpfeTLMjyaIvaepgGydmwmsa1P9kHmOLsy9XC1QRaK3yDSYN4MKa4BneI4AF
	2LyQNbfQEGu/pBa2WvbXT64IeFAZ62QwJ95oUdQ==
X-Google-Smtp-Source: AGHT+IH36/x00Xh4gkPimjkJghxFprOWbRD0VDyx3aqVi0zk7vM4OHwRNy7deO6EqUO9xV6CrWnm6VQxvWzFxXaGLVc=
X-Received: by 2002:a05:6902:1282:b0:e13:e932:6f51 with SMTP id
 3f1490d57ef6-e1a7a1c8b39mr13641364276.50.1725367091177; Tue, 03 Sep 2024
 05:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902151231.3705204-1-jens.wiklander@linaro.org>
In-Reply-To: <20240902151231.3705204-1-jens.wiklander@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:35 +0200
Message-ID: <CAPDyKFpqDRWFRhKP7pH9p0NwfP=tEE2SJ-njKt5AcXtJoUg1ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: block: add RPMB dependency
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Arnd Bergmann <arnd@arndb.de>, 
	Sumit Garg <sumit.garg@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 17:12, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Prevent build error when CONFIG_RPMB=m and CONFIG_MMC_BLOCK=y by adding
> a dependency to CONFIG_RPMB for CONFIG_MMC_BLOCK block so the RPMB
> subsystem always is reachable if configured. This means that
> CONFIG_MMC_BLOCK automatically becomes compiled as a module if
> CONFIG_RPMB is compiled as a module. If CONFIG_RPMB isn't configured or
> is configured as built-in, CONFIG_MMC_BLOCK will remain unchanged.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp@intel.com/
> Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB subsystem")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Replacing "rpmb: use IS_REACHABLE instead of IS_ENABLED"
> https://lore.kernel.org/lkml/20240902080727.2665235-1-jens.wiklander@linaro.org/
> ---
>  drivers/mmc/core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index bf4e29ef023c..14d2ecbb04d3 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -37,6 +37,7 @@ config PWRSEQ_SIMPLE
>  config MMC_BLOCK
>         tristate "MMC block device driver"
>         depends on BLOCK
> +       depends on RPMB || !RPMB
>         imply IOSCHED_BFQ
>         default y
>         help
> --
> 2.34.1
>

