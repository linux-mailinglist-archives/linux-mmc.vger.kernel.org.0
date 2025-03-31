Return-Path: <linux-mmc+bounces-5999-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F144A76303
	for <lists+linux-mmc@lfdr.de>; Mon, 31 Mar 2025 11:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A8716615B
	for <lists+linux-mmc@lfdr.de>; Mon, 31 Mar 2025 09:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E901D89F0;
	Mon, 31 Mar 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfpYhVVQ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191A27726
	for <linux-mmc@vger.kernel.org>; Mon, 31 Mar 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412472; cv=none; b=lYlGVQs7ByNJPLver1XMUUXNFZV9xlZMhpMp0evSr7750VnXJNB8TDcx3b8s7kf4U8QWD1YD6JW5EF9Xrjl3ck+/5EB5/T+yY9ARQxkpQaA6inMvJTGbsZODvxeBn3FiYSbLgmNAYWZLD+l39T0ETywJIoSQNWk7mmjKFL0Ifew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412472; c=relaxed/simple;
	bh=fKCmciuVrejgNfucjb/y/00oSEiIqotqVhoUG09i+hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mLMEpUDYdhI5bahOQwzss+hz7znfkJio+a9EAL4lgYv+Yr5+WEF3Dz/1C7ipFKQEZWoQ18ZTKSAA5QNtJiIHMo1muEu1cCCawLup058NcB56UOWcB5FcGGPqAtI4vbju0mwWIpY8d+1GugkZZy6MyVTqkfuJudXGoYIGufXPczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EfpYhVVQ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f7031ea11cso42915527b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 31 Mar 2025 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743412469; x=1744017269; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efmCxG+jaNBJ2pGe9YTJUnaGnslDF0WWbVSPJUczx00=;
        b=EfpYhVVQrhKV//BvHy0025zthJOr6afBX+9aZvawBccsfbpEEr29JTjm81sO+KAGT/
         PnS3L0GU3FOfoDI6kJL/+esh8aLc12dEZPBNxaURErwA5vhFx6UaIXngZjB5jXwf74N5
         CMumoMOgwHuLdnia9oEpPDypC0CD3144/ZOkpryNW1p/OLi5bcLocgHgTyGp0fAxW3f7
         dYEiqE7OV9+4c70s5gyjql0TuxYxnVKqShgN14Y5rGZiiO5raXl8Lmv1GgwPGYyD20pj
         ZmGHBSEZ2LVtgYEuGb6qNbO6FMZxxaJHV3YGdVdPzCFh+sR62yoTQzRaIulcPjcBOctD
         QAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743412469; x=1744017269;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efmCxG+jaNBJ2pGe9YTJUnaGnslDF0WWbVSPJUczx00=;
        b=Z4HLC3zVRUlsYYSvgMerKAMoLvUZXBptMpqdBGkXB/s7WZsjHBoDbIwU8NWHldnTpp
         AH6zTiMfRaWqDjbvkXVO6EhEBdq57T0bp+pcTR2UmPwCtNQ4TGlqX9DLB9NYlSGkqhIH
         n/fbez+HxJF0ZSeZYf0srC0CIsYTXGeahVgXaqX+uYeMuBuwjRPKlfGFodGLfbvRgefe
         PxlyEZG1NXwyzraq3ud6263afSX3nkr8KAZpiE2Y3lMTnEAvHKYnY0tmKUEDoJG4v1Do
         m/NdCoRcLHdmUQZaB505Dh/oDIQRnGuDLvwVC4VuSoYtsX7hNfq0NOvCKMS/No3PBD2h
         XI4A==
X-Forwarded-Encrypted: i=1; AJvYcCVADWU7tAmb0F+o5yAzmiyFxaQiUB/D6ie1wTzvaTm5Tr6v6oVzyV12GfuiEuk2ov+H3t46y71pLds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtimw35JJI0cum/JP8kS/VvP5MbgJjALZuZHDEYo13bPT5U81a
	oahApZ/tPyEaKU5I4jiOjpoWzb9uTWJgUzKtcpu33aOB5tXZJivciE3lRY+Xge53Ebfu8vMPCkl
	BrycTKWltCMh1Y14mCV3ugiMvgzLLStTwHPThaw==
X-Gm-Gg: ASbGncu/M6cT70bD+MiXMh6Ou7avhpTLk5qx7BIWWhUH9SAtKrS7pPJMoS606yD/zMn
	pGV4E0W+akym/umbK8o1kU8rT1UfOc1nzdIIFq7Qt/QGVNYtwDSU2oSHtyGUlFdLFCMv++42qya
	we9myKENXbrSnrMoU9C73jyARoaLQ=
X-Google-Smtp-Source: AGHT+IHh9xktT34GqhiGsVujUnGGm0FQurTIYLhUauWx5xwssos0oEUywTUlZ+xscELY+5XdU4/SW3GH2916Y6r1a10=
X-Received: by 2002:a05:690c:6887:b0:6ff:1fac:c4fc with SMTP id
 00721157ae682-702573684e1mr117766837b3.37.1743412469616; Mon, 31 Mar 2025
 02:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
 <20250320140040.162416-3-ulf.hansson@linaro.org> <PH7PR16MB6196C3AC7A7B7CA99A70E7DDE5A02@PH7PR16MB6196.namprd16.prod.outlook.com>
 <Z-pQj6ynnfMa77fM@shikoro>
In-Reply-To: <Z-pQj6ynnfMa77fM@shikoro>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 31 Mar 2025 11:13:53 +0200
X-Gm-Features: AQ5f1Jr7WV6ibZ9pOu7C8LaYmbAKrf81E1XaVWgZJi_Ofi4gKPgGIRE2NlhigSs
Message-ID: <CAPDyKFr0MvQDxsi-Qd0F=1KuR4Gy6s5bhVdOXRt9K14Z9sO2Kw@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc: core: Further avoid re-storing power to the eMMC
 before a shutdown
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Avri Altman <Avri.Altman@sandisk.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 10:21, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > > +static bool mmc_may_poweroff_notify(const struct mmc_host *host,
> > > +                               bool is_suspend)
>
> Maybe add some comments about the difference between
> mmc_can_poweroff_notify() and mmc_may_poweroff_notify()? Like make it
> super-obvious, so I will easily remember next year again :)

mmc_can_* functions are mostly about checking what the card is capable
of. So mmc_can_poweroff_notify() should be consistent with the other
similar functions.

For eMMC power-off notifications in particular, it has become more
complicated as we need to check the power-off scenario along with the
host's capabilities, to understand what we should do.

I am certainly open to another name than mmc_may_power_off_notify(),
if that is what you are suggesting. Do you have a proposal? :-)

>
> > >     if (mmc_can_poweroff_notify(host->card) &&
> > > -           !(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
> > > +       !mmc_may_poweroff_notify(host, true))
> > I guess this deserve some extra documentation because:
> > If MMC_CAP2_FULL_PWR_CYCLE is not set but MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND is set,
> > !mmc_may_poweroff_notify(host, true) will evaluate to false while !(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) will evaluate to true.

Right. See more below.

>
> I agree, I neither get this. Another way to express my confusion is: Why
> do we set the 'is_suspend' flag to true in the shutdown function?
>

I understand your concern and I agree that this is rather messy.
Anyway, for shutdown, we set the is_suspend flag to false. The
reasoning behind this is that during shutdown we know that the card
will be fully powered-down (both vcc and vccq will be cut).

In suspend/runtime_suspend, we don't really know as it depends on what
the platform/host is capable of. If we can't do a full power-off
(maybe just vcc can be cut), then we prefer the sleep command instead.

I was hoping that patch3 should make this more clear (using an enum
type), but I can try to add some comment(s) in the code to further
clarify the policy.

Thanks for reviewing and testing!

Kind regards
Uffe

