Return-Path: <linux-mmc+bounces-1332-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F88742E0
	for <lists+linux-mmc@lfdr.de>; Wed,  6 Mar 2024 23:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BBCB21F45
	for <lists+linux-mmc@lfdr.de>; Wed,  6 Mar 2024 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826201BF58;
	Wed,  6 Mar 2024 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pThmoOQf"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5CB1C68C
	for <linux-mmc@vger.kernel.org>; Wed,  6 Mar 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764773; cv=none; b=S36J/bXzZtESPcSQA0ewHt/25xgVv9ipwqzVeJ75S0URmLcEoMiZ7q1Xao+NXe0Iix/J2b7V8MmYQm96utjqkRqclYWpOiq/aXvPLwZCJigbnaEHxIoymS25ZmiPd1B1hQ/zZgPfFjRS/JYu4eQmnhDsCT24/jwDkRz39kAOF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764773; c=relaxed/simple;
	bh=JxK17bHEwL0YPMpQY4ljZfLKRGGd9JkkHlt2xcABl+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dle3xWld9PkBhCsxpJhfHxcAR8WcGbvw5sv3NrGy3lbo2OdA0cV09G07avbFpWrTShtItqd+wzwxpOfElPbsGx2PX6qvo9flqh3rtblEqU9VRu8uHkyS5ZwyaDcvDtXBqRzL8BXIaV0m0InjYSLZlCVn9Ms/BLmp7hsihWqIrws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pThmoOQf; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so1397778276.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 Mar 2024 14:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709764770; x=1710369570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxK17bHEwL0YPMpQY4ljZfLKRGGd9JkkHlt2xcABl+s=;
        b=pThmoOQfMz+w/vR7mFY0J5Qc+bczUVAC1A81/prY6W3YPurWE4Bb88z60JRKwMNONn
         EgZ/korQnPoPIGuD5J2Y0TIbwdEJc8y59X4l+4RSfPnX0V7pamJcztyDgURUpOM44Ihe
         bUM9fb6wghwFVAQ2/0FHyrMUakYeNWeOsqjpYHfogZhpZVFddKtrfRZU+Eu+JyC4oJn9
         Vt95RkVzgU+AK2Lyxu4I9GPV9vSZjj6lp4UCqL9b+StJHYDUI22sWdyPKOwCvCYmBprP
         ZsECEwZWw+UpvwX19PUAFPRAFc1gwwoqRmNoSIWwDY8eWng/+/+44RnGEkGwIeKvEuMo
         dI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764770; x=1710369570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxK17bHEwL0YPMpQY4ljZfLKRGGd9JkkHlt2xcABl+s=;
        b=om2MIn+cRuu5O/VlOoLx7Sg4omkrKSks46dhIfCZTRw2d1+E80jwAjHNBdDmxCtCAm
         oUUDYaBhP3gxYWyMK0Lv/61rzGroTY76yL8McJL4j/OV2UDwLghpAEhMVrRF6D1UAluC
         s7kWz/dnJOHxCSBuE9aHYpBYtZRNuEhBZJIufQ9IXcmEr0ECjGUGq7ZMo4TxW5TKR3AU
         ZqcPNerHB9B9lWazPSJowxJz2jQJ4KxAxeUfr0gAbguasaX1bw6sfAaGq/Cgjbt+2HeV
         /LaaEYACQdlFN1J/9Jk0aFMUOivig+lpouGwx9+SkTAD5/LwWB5AevdFr3cCePIRE3Sn
         1LaA==
X-Forwarded-Encrypted: i=1; AJvYcCVIq+nhfLjpt1UE2Ux9TWZbp+DgdjEtQZlwCxursOYmytyidTOhdea4GpMJmwtvII69hUHKJNXZcNRr4fqoOT3p8XqMny6gZC/s
X-Gm-Message-State: AOJu0Yykl7Trj2S/p+wMcklwslTWTqIf338waajz7Nt0aYFNsrpMIOv7
	30Vb2VAaDwBLiG4j+MwL23xZz0eZ4KD9+ybVh0DcHJIBTZKKHde+pv2o91bBSKBcUMCCtvCFAV5
	VdGU9GEp8ZtwzI6eG3cAA4UFENWxT7iByp89ANQ==
X-Google-Smtp-Source: AGHT+IF61VY2gTAQCgd0GZml0xM8R/GEGUIKU510VpCSAhmbFuO44X6XOlsxI9rQaspybfokha3bpCBK5RV4BUdg46A=
X-Received: by 2002:a25:d652:0:b0:dcf:eb30:c580 with SMTP id
 n79-20020a25d652000000b00dcfeb30c580mr1222007ybg.3.1709764770305; Wed, 06 Mar
 2024 14:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax> <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
 <Zeh8HGDToMoHglD2@trax> <CACRpkdZ1ervTXj6++oBPDNJT3TpVgPeYsyhaEMRYavJQ5iZPqg@mail.gmail.com>
 <CAPDyKFqYDPgNjSkpH=XATkUY2XtjsaDstChcAnGxoas4jgDVfw@mail.gmail.com> <CACRpkdaUUD8UMp9GxNVQfdAM8QV_LASp-k5hh1cvQrGVHKySKA@mail.gmail.com>
In-Reply-To: <CACRpkdaUUD8UMp9GxNVQfdAM8QV_LASp-k5hh1cvQrGVHKySKA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 6 Mar 2024 23:38:53 +0100
Message-ID: <CAPDyKFrdki=OyQWHghF6R3ukv9R6FRQfxRbUrSKfVJ+CNCjXTQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: Linus Walleij <linus.walleij@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 at 20:49, Linus Walleij <linus.walleij@linaro.org> wrote=
:
>
> On Wed, Mar 6, 2024 at 4:57=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> > On Wed, 6 Mar 2024 at 15:38, Linus Walleij <linus.walleij@linaro.org> w=
rote:
>
> > > We should probably rename it part_cfg because that is what we
> > > store in it, it's assigned from card->part[idx].part_cfg.
> > >
> > > Then the id field in mmc_rpmb_data should be deleted along
> > > with all the IDA counter code etc and the partition name hardcoded
> > > to be "0" as there will never be anything else.
> >
> > Seems reasonable to me. Are you thinking of sending a cleanup patch on
> > top of $subject patch?
>?
> Yes I can do that once this patch is finalized and merged.

Great!

I don't think the $subject patch is perfect, but it's slim and
suitable for stable - and of course it seems to do the job well. I am
therefore queuing it for fixes, thanks everyone for helping out!

Kind regards
Uffe

