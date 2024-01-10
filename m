Return-Path: <linux-mmc+bounces-552-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DCE821FBA
	for <lists+linux-mmc@lfdr.de>; Tue,  2 Jan 2024 17:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED40B20B26
	for <lists+linux-mmc@lfdr.de>; Tue,  2 Jan 2024 16:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D714F9D;
	Tue,  2 Jan 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOGHtBB+"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9314F92
	for <linux-mmc@vger.kernel.org>; Tue,  2 Jan 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f15a1052b3so18736557b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jan 2024 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704214552; x=1704819352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNqL3syd8tajxdXP6DeZWAspQXGwstc+HdsQhu/G50A=;
        b=IOGHtBB+A2YpRHNpVLTI+6mbYTwnFix6w/wUEiZPom/SAbpYZ4gCQPuvmSFwfAqH8V
         nAwxMmNLNL5R7Mx4nyttoVxe10h5dt6cxgKskDuPTIcGXov+zcHaHWSNsuCv9qJMoTCf
         CSTPVOxoD0GnV9fCpY/uMRFXkqoXkFfpJCkLD6VWX5lHkfD+xhHh7jKu3qTVXRualz9G
         jb9FLzFdMP7Thm5MioKoo3qHoN9F3VWVyyfqa6/3k1DrJIzCdxy9rjRICqLrMs8y2tsy
         xeR2yFiGsDDPw9rOCph04n8prtnZcfsF4rpH43BFnsophlzjc/LGIpJxcunob/gC2W3C
         L3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214552; x=1704819352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNqL3syd8tajxdXP6DeZWAspQXGwstc+HdsQhu/G50A=;
        b=Kd8qJd2TWLyK6L6LBYrYUCymRjr2rPSzob0F5QxPabZlip+m0dsuyQdErNxoIjfTts
         43SO+pzxRfKUpb9r34D0NspdUVZXMkJtSFypu2LbPQcdddHgIRkw8y9qCwqKdsIWLd8I
         2xRsnSo4hwJw5Fh3xp7oVCc7vIQyopeVJW94rXygd9oL45i8lzZmSV2pvQXoT6hDpuqk
         EnmaDwkL1wdcTEKwt4JMXsqJhiL/etUcF0MHzFp8z5C0YbCRHmyC4a7sy1tUJLkH669w
         J6YP3aaCxzapPM2FAPf32LgBhknaR1f5Dn5Bt9ZAIEJBp7n4tlo3CvxAjy0WeV93cwQF
         EZrA==
X-Gm-Message-State: AOJu0YyepVI6TQf7B1KP8rAb0bhWq9cWEtq62ziwnQ97W1OQ0iCJagGl
	nAu2alW/FKD6iCsyCDagU2+BCUHJWtqDW0LahK0ooTbZlIYYNw==
X-Google-Smtp-Source: AGHT+IH38GyzntASw7CHnKSqj+ZQZUAgzv27O4Az+xAQMxD5JqXuBWTwK69lQ4VL7IfiINHMXODTxxSi7cIGSCiDaF4=
X-Received: by 2002:a81:4a44:0:b0:5d7:1940:7d8a with SMTP id
 x65-20020a814a44000000b005d719407d8amr10235618ywa.97.1704214552024; Tue, 02
 Jan 2024 08:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213224219.2191721-1-robh@kernel.org> <170421203410.2946186.5030215776329721242.robh@kernel.org>
In-Reply-To: <170421203410.2946186.5030215776329721242.robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Jan 2024 17:55:15 +0100
Message-ID: <CAPDyKFrOc9MnvjOjA8Wg_zFg9G2rtxoTs_iEY1oLWME59v1jiw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-pxa: Fix 'regs' typo
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jan 2024 at 17:30, Rob Herring <robh@kernel.org> wrote:
>
>
> On Wed, 13 Dec 2023 16:42:19 -0600, Rob Herring wrote:
> > The correct property name is 'reg' not 'regs'.
> >
> > Fixes: ae5c0585dfc2 ("dt-bindings: mmc: Convert sdhci-pxa to json-schema")
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
>
> Applied, thanks!

I was just about to apply this, sorry for the delay. Anyway, let's
keep this in your tree this time.

Kind regards
Uffe

