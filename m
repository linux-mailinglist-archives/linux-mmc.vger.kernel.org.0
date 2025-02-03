Return-Path: <linux-mmc+bounces-5392-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F67A266FE
	for <lists+linux-mmc@lfdr.de>; Mon,  3 Feb 2025 23:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51904165E26
	for <lists+linux-mmc@lfdr.de>; Mon,  3 Feb 2025 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9A92139B1;
	Mon,  3 Feb 2025 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aPQPmJ15"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954821146C
	for <linux-mmc@vger.kernel.org>; Mon,  3 Feb 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622384; cv=none; b=kf4VtXDng6uPr63+yce1qqbrDJo+1HUgnLlOswmMhsTugayR/RvnT5QyYFIrP/CqCzmYnh8lE28vrSiY9e0FiKzabhoTwkkBPp4pMGfjC/qvbfr6uRozxobUo9Vxc003H8x5dhx6JuIWbhGLUg1g3S4ZvADDB1eho7SlofXugWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622384; c=relaxed/simple;
	bh=1Q81xARcDqJnn1HJ52uZiPtHrThD/Lg7LAxKl0LKqW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFvdBslBKOa6zznQxp+f+TfQJ3BoeQLkASHyi7B1DP1PzFZYGBLCYHiCj2dUlYVd2BcznB89DZwRe/hlyZDb4Wg0b5BptbKTOAmktdni3k1GeziNxZR4wgXV64dABYoYa1t5YNtPJFI9RK3J6X44SaLfOTm6c8zyghVRZmIewRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aPQPmJ15; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2b3680e548aso2298373fac.0
        for <linux-mmc@vger.kernel.org>; Mon, 03 Feb 2025 14:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738622381; x=1739227181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FuOTM/5uq/stUm6NdRcMUJvmEyi2R5GtNjpDeIV2Ho=;
        b=aPQPmJ15Elz6EyybHgCejqIswr6xI/YwwhsV8o9hsaPsktE38IzMJsNBUtTxo0lHVJ
         d5/bzL9Ol2TeAbPw4QQ+erQ9PXa4CCrjw0qexljVFSd6gW90iQ2ila46nIgpMRPkoTZB
         pnczcpTCKki/Ohld+kjX4wDf7uVrNEY2kueUCJ7hSO/ig3iiyr3VUnU1LryALo2uOuFH
         2lfdmn0wq1uG4fOasqrbW3QP9Fc5MbVxPu8iE8/OFd6/tTh2jjNviByNj91xjtMl3ypm
         +r8dceFYWeC0RZhEsSs4hnqv/7Wn/9qivtGIHpVtMBlnW0bAoGhvCtMFN1oPY9ihyOmc
         07DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622381; x=1739227181;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FuOTM/5uq/stUm6NdRcMUJvmEyi2R5GtNjpDeIV2Ho=;
        b=P1IISCDGuok78sb2arG98oSuGq1+vfawyQYPmpvpIhctgeKHnn4SVigl3/uWaZMHK+
         f1y87x/vInzEIeN65xUNamDw/wPDbgE0028TD/bUdFFU9Lq3XCuBQ1Eet78fxRocBTMn
         e49hkvbUhXk7+ixXt9jhTuBul9I8lW9rR2WeTwijcb1oRBGUmD3cf8jJjCx0vG+BB8Nc
         TrDbqHCiqeHpdl6M21L+BedFhUgetigfkm+8kONFLj1sUh1GqFn34uiSCJ9XMbv32xLk
         IphPAN6rG+Zj0PiUzkX5fW7tGiX9o4Chplnoc47GPIeSXo//NSSXR3rhh3RsdpBjpZFm
         OTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEwJHtoA7JhUm3sMEpWKz+Ds8lrJXo2UM8yBZHPlgdFGRcEus0b3pHrjmwmHvGjL1+9EuGDHtViMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQFa774PL6dduyVcvry7MypMgjvo8TiORITcoW3TGELSW7kCP5
	okD2gcWh0UzIhPIV8CLzyjaTetJNelxTVt8ykVN4mzejXShvxCmWn7knpk0UumA=
X-Gm-Gg: ASbGncsigpcsUnQdyo4fP+4yOqr9Fx1JvRw1HD+0bC7ym/F0/TOwIRf/tUQnyRqKHOb
	APY4UfrtHSfKVxJuGSv7SZZMdPWLopcMANBXrlNmfX/qHE2qWLrBclajwtf+oGBrLULmIOi93GK
	R7HHGUZtyLEHRbBC56oqbiYkcWoATUJ226HcK1ZGn0xXdGvTEqjkRzC0yO2XXvUm0UHgXZc+IV+
	Ykb873Rjthe+eNuhJdysdK32QTo1q8VYTdkkatDdcIBhhEnxeKkMAcmpBuofNdmDGo5xrwoBu0D
	Py0w4xaquk17NiBCh4y4aCImJrNnCUOjbxPbMvX6fiIxk0p7ZjUU
X-Google-Smtp-Source: AGHT+IGaQH53OWXI018UHR+o3pOTGmyURoCZWzCbG0RQLmUMPYxUrDO3psb2lp4Kuy+CvmoE1eZtzw==
X-Received: by 2002:a05:6870:1b14:b0:29d:efe8:5a49 with SMTP id 586e51a60fabf-2b3e7450705mr688192fac.3.1738622381243;
        Mon, 03 Feb 2025 14:39:41 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35619ec30sm3589105fac.14.2025.02.03.14.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 14:39:40 -0800 (PST)
Message-ID: <b1c35782-f717-4fe5-8a00-7f13b341b5dd@baylibre.com>
Date: Mon, 3 Feb 2025 16:39:38 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
 <9931433b-5cde-4819-ac96-eea4f1f0f1f2@baylibre.com>
 <CAMRc=McEdcDs01BAKN5vg9POg_xxJBY1k8bfgiDN60C1-e_jow@mail.gmail.com>
 <072be5a9-e0fb-4073-85b3-4a8efcafae09@baylibre.com>
 <CAMRc=Meq_Gfhcjzx0vCL0JPzfnOcijFgB6AuqtsqgGn1eOTMVg@mail.gmail.com>
 <CAHp75Ve+iwrm8dx49+6C7xFJgTQrh3XumKVzKvnYY=00J-j43A@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75Ve+iwrm8dx49+6C7xFJgTQrh3XumKVzKvnYY=00J-j43A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/1/25 1:47 PM, Andy Shevchenko wrote:
> On Sat, Feb 1, 2025 at 6:22 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> On Sat, Feb 1, 2025 at 5:17 PM David Lechner <dlechner@baylibre.com> wrote:
>>> On 2/1/25 10:14 AM, Bartosz Golaszewski wrote:
>>>> On Sat, Feb 1, 2025 at 5:09 PM David Lechner <dlechner@baylibre.com> wrote:
>>>>> On 2/1/25 4:36 AM, Bartosz Golaszewski wrote:
> 
> ...
> 
>>>>>> This looks good to me except for one thing: the function prefix. I would
>>>>>> really appreciate it if we could stay within the existing gpiod_ namespace and
>>>>>> not add a new one in the form of gpiods_.
>>>>>>
>>>>>> Maybe: gpiod_multiple_set_ or gpiod_collected_set...?
>>>>>
>>>>> I was waiting for someone to complain about the naming. ;-)
>>>>>
>>>>> I was going for as short as possible, but OK, the most obvious prefix to me
>>>>> would be `gpio_descs_...` (to match the first parameter). Any objections to
>>>>> that?
>>>>
>>>> Yes, objection! As far as any exported interfaces go: in my book
>>>> "gpio_" is the prefix for legacy symbols we want to go away and
>>>> "gpiod_" is the prefix for current, descriptor-based API. Anything
>>>> else is a no-go. I prefer a longer name that starts with gpiod_ over
>>>> anything that's shorter but doesn't.
>>>
>>> Oops, that was a typo. I meant to write gpiod_descs_.
>>
>> Eh... the D in gpioD already stands for "GPIO Descriptor" but if
>> there's no better option in your opinion than I guess I can live with
>> that.
> 
> gpiod_set_many_value_cansleep() ?
> 

OK, taking all these suggestions into consideration along with having recently
come across regmap_multi_reg_write(), I think I'll go with:

gpiod_multi_set_value_cansleep()

