Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92FA515D03
	for <lists+linux-mmc@lfdr.de>; Sat, 30 Apr 2022 14:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbiD3MpA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 30 Apr 2022 08:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiD3Mo6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 30 Apr 2022 08:44:58 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A330102F;
        Sat, 30 Apr 2022 05:41:36 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id z5-20020a9d62c5000000b00606041d11f1so1057558otk.2;
        Sat, 30 Apr 2022 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+4KmgQYfIuFm8h1U7R2YwSpU4hiAkXj3VbXO1u4n31Y=;
        b=bOMCzvCOAKpdv9fXaje9jMI1pqeKHqZONG1kyrwpEn5SRSjZ3gWLYQa3I3V8E0XTqe
         23L3GQAWJeNEVk7g8b+1UkAgEnQmLz3wKCy7oL9ps0rKBiKWBGcNJePTi8yZdc7eAm1K
         drdd70QPm41ZeopLgQmmcBSPYqUdoh6aLM9KWSTIn7/lTrG/Cl6+v62W2AmGpZwfQKuG
         nJsb/pkjFRynFoTYu5l6pn8u9pt2CaT1jCMhsjk/5NBUgOkrkYq3BZENTznAZdLbqTNg
         OGQz6xI5kVYIDfriuLeWqba0UWos0/qt3bWMGA48AnxKNk/33rWth8ALS3TZQJlUqq9u
         /Xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+4KmgQYfIuFm8h1U7R2YwSpU4hiAkXj3VbXO1u4n31Y=;
        b=2eKTkE0mtN5koY1UIxv5K/5k1vHT7cMa2sIqOYiK5fP4HsZrmECuxLlgUUKifvUgvl
         otLiqrRpRdyZZQfggehIM2AvFIaRLEULV8znL6IYhNcUdLmo2quETDJnwThF5riZ5elI
         JeMpJ1MHJUqJA2ngD0nAaTLdbNWBiCXqYsA+raYdZ+q2B3/HPeHMoJLeulHqKx7IgL6s
         urnpNTAqaujPTX8Ebwp+nsOKsgKv6reyLxELmtRCMTvLlMyGvhlvIcgRg678sr2+Nc73
         yV95GipK7EHKdnIP0XqtOCAYudG6/+8HHyj7aLG+mGYuUgar5jrWa4OBtrTE6+G3MZA0
         sJng==
X-Gm-Message-State: AOAM5338euTdLyOe6KP8GGEEf4ETyVDCn+HeNojjTNFevLbmFZL7JKRW
        pJ1X4phsIOrmZacKus7o2e0=
X-Google-Smtp-Source: ABdhPJx/RnInjVQBRODIzLjFN1nUE8Qwa3akS1eWhsyayobpVL5cALhdflWKmFg+xyGlLB5eP7Dd1w==
X-Received: by 2002:a9d:6957:0:b0:605:de97:1ac9 with SMTP id p23-20020a9d6957000000b00605de971ac9mr1368958oto.83.1651322495923;
        Sat, 30 Apr 2022 05:41:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c5-20020a056870b28500b000e686d13881sm3932471oao.27.2022.04.30.05.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 05:41:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b13783aa-9225-d52a-3800-c97ad772688b@roeck-us.net>
Date:   Sat, 30 Apr 2022 05:41:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
 <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net>
 <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
 <20220422234150.GA3442771@roeck-us.net>
 <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net>
 <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net>
 <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net>
 <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
 <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
 <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net>
 <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/30/22 01:04, Arnd Bergmann wrote:
> On Sat, Apr 30, 2022 at 1:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 4/29/22 14:46, Arnd Bergmann wrote:
>>> On Fri, Apr 29, 2022 at 10:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> On 4/29/22 10:48, Guenter Roeck wrote:
>>>>>
>>>>> I tried the pxa-multiplatform-5.18 branch. Its failures match
>>>>> those in v5.18-rc1.
>>>>>
>>>>
>>>> Uuh, wait, the build wasn't complete. There are still some
>>>> failures. I'll report later.
>>>
>>> Sorry about the breakage, I got a few more reports about minor build errors
>>> and warnings, the newly uploaded branches should address all of the ones
>>> I got reports for.
>>>
>>
>> Unless I am missing something the failures are the same as before. See
>> https://kerneltests.org/builders/qemu-arm-testing/builds/74/steps/qemubuildcommand/logs/stdio
>>
>> This is with v5.18-rc1-49-ge8ab9a9a2745 which is the tip of
>> soc/pxa-multiplatform-5.18.
>>
>> Should I check a different branch ?
> 
> I only addressed the pcmcia probe failure that you reported for the
> final pxa patch, which
> previously caused a NULL pointer reference here:
> 
> [    1.405319] PC is at pcmcia_init_one+0xf8/0x27c
> [    1.405476] LR is at devres_add+0x40/0x6c
> [    1.405611] pc : [<c04bdea0>]    lr : [<c044d808>]    psr: a0000113
> [    1.405846] sp : c48a5d00  ip : c15f4220  fp : 60000113
> [    1.406026] r10: 00000000  r9 : c48b000e  r8 : c48b0000
> [    1.406195] r7 : feeb0000  r6 : feeb000e  r5 : c15ec090  r4 : c15ec020
> [    1.406395] r3 : 00000002  r2 : 00000000  r1 : c15f4200  r0 : feeb000e
> 
> This now seems to work:
> 
> [    1.435846] pcmcia_socket pcmcia_socket1: pccard: PCMCIA card
> inserted into slot 1
> [    1.456350] pcmcia_socket pcmcia_socket0: pccard: PCMCIA card
> inserted into slot 0
> [    1.457489] pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 217)
> [    1.460275] pata_pcmcia: probe of 0.0 failed with error -12
> 
> So it sounds like there are additional bugs that I have to look at. I
> probably won't
> be able to do that in time for the merge window. The logs contain a number of
> warnings, but I have no idea which ones of those are preexisting issue. I had
> a look at
> 
> [    0.689982] pxa-dma pxa-dma.0: error -ENXIO: IRQ index 1 not found
> 
Yes, those messages are indeed old.

> and concluded that it must have done this for a long time. In my own qemu
> instance, I see a crash from iWMMXt, but that works fine on your machine.
> OTOH, your failed instances all look like they either time out or
> failed to find a
> rootfs. I tried passing an MMC device as root, and that works here.
> 

Booting from mmc works for me as well. Booting from pcmcia worked before,
so I assume that there must be some regression.

Guenter
