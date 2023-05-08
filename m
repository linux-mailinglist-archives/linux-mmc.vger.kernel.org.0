Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377166FB9C2
	for <lists+linux-mmc@lfdr.de>; Mon,  8 May 2023 23:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjEHVbV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 8 May 2023 17:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjEHVbU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 May 2023 17:31:20 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5417B869B
        for <linux-mmc@vger.kernel.org>; Mon,  8 May 2023 14:31:18 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so27331773276.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 May 2023 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683581477; x=1686173477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOJR/20LVKyz48EAyeHc1+jVArD8eFRaiPVz2llKJYw=;
        b=xnPwIs1cwDo2FfYER/sCJ/da+7w70ojR2vcIjoTIwWXCv32mMF1zm1BD4+lfb2YBZM
         a2JVJMgplb8WbXqgCdHgK8Kp72gs89jO2wf+8i72UAlWKsMEO+QAvE2kzbL6W+zsK4XX
         5Z8iTG2eG+u2fgFxWPNmnpwDmCvRMpfx0fMcptbYfNamY9350JY8Gd4qdqq2mPQh9kC0
         +x56ZfIKBMwAlE8P63WHOLZVXUP3U77r1pEjelQEPWycVNYaZZsW7RV6EqwWY1pIciet
         mUJNXjEV6P9b/N9Sms+auwR08F+s4xsHpxn7JhrpRdBY15Z66VnYReC0HO7LXkTpsCWj
         0ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581477; x=1686173477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOJR/20LVKyz48EAyeHc1+jVArD8eFRaiPVz2llKJYw=;
        b=Yh0rZdRI+f4+wObiJoclGwXEtAF6/P3IK/oIlbTs9xjJn1g5kbqSk5GPYAEm7dri8u
         SFJx7mIL8iWP19AZLEnDkXJXV91lJNpqmBwSomsKSaHSR+/htHY8wgjb9MgkbNInALnF
         OTV8sDtI7rPAHe11Vd+DfKshhU2Oy5f52h0yzvqA1VOVsNUkWx54gs2tJTOLG2NrKFJp
         f/fp64kNDwymDWMwYEAvPYKq+qtQrgbIin/W5K3dwMg6gTVSESnl2wuT8iq9uJaFU9FE
         ftrfPefnYSRQbNDOnUW1sDbSe9p6K7L7mgqCVfINdHklOiwouz3nbyeeU+5dXR+4dKUT
         6gqg==
X-Gm-Message-State: AC+VfDw83Elxl6LvdatD1oSaqi+ggvSFlnVJUNAqp+O3WQls5K+Qj5Jk
        DA5O2VhYY1oJSZRzBZZSusonL8+NtqsbZMCgB2u4zw==
X-Google-Smtp-Source: ACHHUZ58fReQQ4pRCBtoCz9Lw0P3GVuCrDW/FKsG0+nk/YgPWCXp8EO7CBeqYU//QyxCun6JDuY2iPWmdeq6/W2Qfd0=
X-Received: by 2002:a81:4c4c:0:b0:54f:54c5:70d with SMTP id
 z73-20020a814c4c000000b0054f54c5070dmr13840092ywa.20.1683581477497; Mon, 08
 May 2023 14:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
 <20230430-nokia770-regression-v3-1-a6d0a89ffa8b@linaro.org>
 <ZFVGMiuRT+e2eVXw@google.com> <CACRpkdZUXOTOK9CObdXuHQx4PMD3ykMKco8X5ijchkZ8cEmQvA@mail.gmail.com>
 <ZFlpYff6I5V6JiH1@google.com>
In-Reply-To: <ZFlpYff6I5V6JiH1@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 23:31:06 +0200
Message-ID: <CACRpkdae4+0vsJS71G6dR5PEpMw13JGJAJr9Jyf2T+Z8gOgoxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Input: ads7846 - Convert to use software nodes
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, May 8, 2023 at 11:28=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, May 08, 2023 at 11:23:44PM +0200, Linus Walleij wrote:

> > > This needs to be
> > >
> > >         return !gpiod_get_value_raw(ts->gpio_pendown);
> >
> > There is no such function. The gpio descriptor runpath simply assumes t=
hat
> > device trees can be trusted.
>
> Sorry, this was supposed to be gpiod_get_raw_value():
>
> https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L28=
54

I missed it, I should have very well understood you meant that one...
I just read the file too sloppily.

> Yeah, we we can land the DT fixes ahead of the driver change that would
> be great. Otherwise we need a temporary application of
> gpiod_get_raw_value().

If the patch is fine I will send it to the SoC tree and ask for it to be
applied as a fix.

Yours,
Linus Walleij
