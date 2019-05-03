Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3112F2A
	for <lists+linux-mmc@lfdr.de>; Fri,  3 May 2019 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfECN3e (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 May 2019 09:29:34 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34497 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfECN3e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 May 2019 09:29:34 -0400
Received: by mail-ua1-f65.google.com with SMTP id f9so2012021ual.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 May 2019 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtQarfjvBVELqAYN+Ba2dtNFq+u9qtxgeg7ns1Ue40Y=;
        b=WaxjY/WoDhL7nGbSX7lFGJ71jz4K7qOKbL3imHr9auDwTMLOQMSV75mOHf/Igr2G9f
         Zsa5W7OHaDLyXkHoPAN2Xk6cSZ97mvLHxfPtqDDrTDM3mJY5LF+V9cxKj7BBE8bgGuZ6
         ighhVpC0VpwHAdNGcRo4ludLrz+jyeP+mujh9jaKf1S6ndI+RLgMhdQyDOV8THcrdVcK
         McHsHze3OBzsuMbSJ7Rw/3u9QVwIwFo/fDkZJZMJNOY98P9uKvsrN+Wa1sxtDS16IcTt
         44LwwYm8nq2f1BtmrkYVvR9YUPGCgyaWXKuMDNtszOnv2QR0fJXcgXXnajJR/lU2fyRK
         BlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtQarfjvBVELqAYN+Ba2dtNFq+u9qtxgeg7ns1Ue40Y=;
        b=pWUmrigukDvtWzYtCsDv3x1E0rQvdZZMQBBUE3D64ptCFSQp1B7bcZom4LFV2G0i42
         0DYtz2RfXoBZJN+BgDIWcZecPSifLo2r0lK8C48BfbII7YunuBWLLe9I8wWGt9bn+H/K
         zhKzjBe+ETWejepWgVohFVSWEDF5lfPx9fI2XCE0GJCIHjzuiOGdpmdS8+BkIgGscdQj
         qwtC+sCF8aNgPK1WBZfBBdS4u1lYh+b2TL6GQKlD3e1ULHXr9nLzrOwlCHEBjZNkol+T
         c9bem3Dn4tnnyUvC2B54Q8iYbBtqXaN67bqA2Nu0v0ESXJWOnPoof6WrPHP552VHYtv1
         dD2w==
X-Gm-Message-State: APjAAAWqOGY5RyJnvXw2XAub6a7NoJesnU52SF6sKsRAThydKvC3SYOX
        eLUJGSljAFfRHYTTyohbzApoQxv6HIsJyLo5N+qa+w==
X-Google-Smtp-Source: APXvYqwnmdGyKdfMPiSIuwt2e0HNuMqoxfqgddY3iC09i4sLQrrpLWQU83CoFwPzamWtIIajUnTeAeKS42MMJHYU/dg=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr5169793uar.15.1556890173163;
 Fri, 03 May 2019 06:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 May 2019 15:28:56 +0200
Message-ID: <CAPDyKFqvkn0x6+AWKwa1xxj1adj+Ehy6jmoqPfh=0Dhm8AxzCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 29 Apr 2019 at 12:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 23 Apr 2019 at 11:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
> >
> > The purpose of this series is too improve reliability of the amlogic mmc
> > driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)
> >
> > * The 3 first patches are just harmless clean ups.
>
> Applied these first three, postponing the the rest until Martin are
> happy with all of them. Thanks!

Applied the rest of the series for next and by adding also Kevin's tags, thanks!

[...]

Kind regards
Uffe
