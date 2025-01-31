Return-Path: <linux-mmc+bounces-5345-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 252C5A2443E
	for <lists+linux-mmc@lfdr.de>; Fri, 31 Jan 2025 21:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00B61887971
	for <lists+linux-mmc@lfdr.de>; Fri, 31 Jan 2025 20:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE401F3D5C;
	Fri, 31 Jan 2025 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TGTDqg80"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4F1F238C
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738356717; cv=none; b=MyAUN+rjPNRm5WgoUlp4vQyzfNMrfmFdx5A2jDz4FCNd2i/hfTghhJiqPxRs1ZQGqCyHm5Fp8nvaslnQyJpXEFAqkqjPOSVv6IUEXelHkPDpRWkgFhgCw5T4apyIoGQBbUfBsMNZtIYIvEfV/tgD+yKWeodcTcl69jbt+pQMtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738356717; c=relaxed/simple;
	bh=U62TgxY+A9dzDmv7rb3+XOMVxcMlVdxMGP6cQwDn7ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHe+ifkO6OcIRvwjR34AQ7fLk+jeC7u1AoM6PfNi1RMo9mpOm6zKhvnIl+pQZWbyUAKxsAJmbBdyTj8dWGtV6PuZMhS9y3wQuvdKWcnubQ+4ydazS6kkSm77PNObj8uUjA8FNxPZ2oyHLqDj8vKYV6DBvuYQmIhZvmJ12Qt6YE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TGTDqg80; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f2e13cb359so676744eaf.3
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jan 2025 12:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738356715; x=1738961515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSDpmKyHnv3yIYrHLwgKwckV132tbtKpwM8F+9YvHNM=;
        b=TGTDqg8087ioyl9s6ESDaLblLqWuFhzIa+IGVGRg5TYZoh9ycwk64DiiAS7allW+2f
         XAJLMsDCaCkwunv7v4lY2u/NJwWNwjXCeiraOzq4WoWNzARdXZWgDSGpM7GYYBP0P5de
         HdcdfcG8Ws1d2S/uecNAjZ+ZvA4iDyNTD6Nfb7F2DPgmK7ZwehCVP2BoqrymsSzHn4fU
         e04DyEvVP3T91mpljezOaVblexNLr0LTJLdJ48BlO4G+6gB8tgnXk8BnhSEj1t5618n6
         wCBkjxBG30+ua16uirzOmp5Q/SCaNx4WGWEbkRQEdwXf0Mp+jJq1CVYCKPCY8FfVK1bj
         7LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738356715; x=1738961515;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSDpmKyHnv3yIYrHLwgKwckV132tbtKpwM8F+9YvHNM=;
        b=EGbZOfTYaGJqjeBKMwBARImV2535t2h7iZ1lNoZTv2J2scljFWn7g/+UQYsAktIDO4
         3Habl/Icwh5cq32zz/oHvPdv1T6fNhV3/mKHt8i9iS0GlctHlBi8YGzAKIRN9ZZaiyrJ
         nKgKHBPZbgGORBZMIuFSvBCJSYPh9v2gmvhFdZatNq+ZTdsuqmx5Z/6KEzkf+cZxTVdd
         Cq31cwx2++HOCRw7DW0BWSVwy10dE8zno2ETGaeY+7S+6+PHQTXxw/Ds4PQ/ySd1DRI3
         RC0PEWpyPF+YHOnCDDwcZBeefYJSbyDHeck8OG/EQOOIh1BoyOORGmPFp0yuLNgqozJK
         6m1g==
X-Forwarded-Encrypted: i=1; AJvYcCW7Nf9ZSFVxPwYZIFFQqtFFXIvNWwCbeRSsoETEIih7/Qk1IMSWR0Q2QV7qW6oYLjV5yAtj3WSgZFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQsvCHZZdbBjw3so51kvUx8Yk3EFLXajYE72q2BU8rYE/QH0kp
	lHHF62gp/Bj3zHhtzkfJr4deor3l+R18TaMIFVxVnKld8V3RiP+JUDVr56EWrn4=
X-Gm-Gg: ASbGnctgPd3R8jlSJ4jXGWxHqaODPPG8sO0/i1NFjEC2NdEZvgGEOR1DFLZyuuHZ7eB
	tJ2oRPzNVXOm9gZ5ZBbE57aVdULuGq0AzDrzYBiF3e3WvDkIhg6cgXtpJL4h9EtvgLmbQ/FgbBy
	TgyGQHDb9oKCVUmthZGS4H3bKN20Y5Qabug31seVUhojCv/uNw70ka/46EKdQXdjBpFSXFAnkiK
	GM3Qt30kuKsEvDAacmb0XKxbwrKzk3nO19LNvKHS0qfAcxHQx8u0kSQCThX/qncM7GN4FZJUKPp
	BU2jsVZibv5gQzi3M6zEbWFyEyJ5lPwjnXKRDAMFdn9c8MOgv+Ry
X-Google-Smtp-Source: AGHT+IHPMh8KitUWz2IouQzz/azYXMRtpN/Za+AnvsTlT7ulHOR4Zb5ZOPuM1rHtwe4+cYrz1u66kg==
X-Received: by 2002:a05:6871:4915:b0:29e:684d:2739 with SMTP id 586e51a60fabf-2b32f2e092cmr7943100fac.32.1738356714641;
        Fri, 31 Jan 2025 12:51:54 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356111477sm1426322fac.9.2025.01.31.12.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 12:51:53 -0800 (PST)
Message-ID: <2715ead8-cf6d-4b44-b6e3-343cb6489eca@baylibre.com>
Date: Fri, 31 Jan 2025 14:51:52 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Rosin <peda@axentia.se>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <4ad45123-134a-4544-ad0a-24371105d96f@lunn.ch>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <4ad45123-134a-4544-ad0a-24371105d96f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/25 2:38 PM, Andrew Lunn wrote:
>> So I'm proposing that we add a gpiods_set_array_value_cansleep()
>> function that is a wrapper around gpiod_set_array_value_cansleep()
>> that has struct gpio_descs as the first parameter to make it a bit
>> easier to read the code and avoid the hard-coding temptation.
>  
> This looks reasonable.
> 
> How do you plan to get it merged, since you cross a lot of subsystems
> here.
> 
> 	Andrew

Since these are mostly small changes and most of the touched drivers aren't
seeing much action, I think it would be OK for as much as possible to go through
the GPIO tree.

We might need an immutable branch from that though since I know that iio: adc:
ad7606 is currently being actively worked on.

If there are any patches leftover that don't get acked to go through the GPIO
tree, I can resubmit them after the next kernel release cycle since none of
this is urgent anyway.


