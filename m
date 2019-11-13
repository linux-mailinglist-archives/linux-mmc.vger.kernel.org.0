Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17B2FB12F
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 14:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKMNRy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Nov 2019 08:17:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44260 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfKMNRy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2019 08:17:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id z188so1904277lfa.11
        for <linux-mmc@vger.kernel.org>; Wed, 13 Nov 2019 05:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODdjAsv6V42vaVg7OoS5YP4kHhdsnwsr8eTSaT+/TyI=;
        b=cAUOWGd9VlFqH5jzJiEP2SX1oEbTG4eUyljPTjFnPWaCuBIZtZIyYnQqxHEiu+PQGO
         BrEcQ1Cu8NQJZsEWNx1ccJ+yIfODPTVv8Vv3Vc7xEBKc8HhipY6JuaEqEGLlHZQNdtwS
         AXkJNfOi2XFtLUFJJZcjnDVlsGlzBx2env2DS39kWlq7d91iilbK6kK6oH6xXxtKAFsT
         zVyCS9YUNqYayXwTh5RfehPgMvuA2OVdINitY02+JaUS7kvMM4A/+1OJQsUdReTkCV44
         8AEwDVllvRLQAD06lvZkK2qMCyoE5UaOghUuzZbaTrteieKE8pIyvgHinDJ4YthMAr3W
         iglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODdjAsv6V42vaVg7OoS5YP4kHhdsnwsr8eTSaT+/TyI=;
        b=ndhxBgfeyQjyfU09LM8J78t9wr6aTh82tRDLVf0DcG4o2i9GT2/aeId5LOOYfwsTXw
         dGpy+qvhxtWz/nxNNcmtlXNUsWUyYupLBEnTT1qXAuwzOfrbxwZkCfY7Pr2HVYCMnkmg
         lBIMBY/zkTxrnzvibDjFNbAn4AaZS82NyIRNV68OhNDLzg2rsZNy2F6M0/ta4Kjsof+s
         fBgAQH29XlaaFMd/a/bVyvkwC3qXTFCU/dUxNIkTnAtE2ZglEO8LDx7R1mO6HS9oOUcN
         Kjj1cXWAg7G4+fQxe+TpjZLGPyU9ccnUcWpE7OKF7wHD6Gpuz0gA5eAGpUmloPzFUC7o
         ayGA==
X-Gm-Message-State: APjAAAWPvRSJA7Tt74vIurhfQvutCeURvwLZ9QAxJyV6GZ78vNlhoRfv
        ncp4FpxAk+yyVC3IPtsbgza9j1H1QkB+1iJB3IuXrIL4oLw=
X-Google-Smtp-Source: APXvYqx8siTYYDaL+IE0BEI1+P+9W94Je2xzQCR4dKQpvN8lQXygO2DokX4wXnJNdzV0d0Q/PDb6Oiww7sjiGj1A9XE=
X-Received: by 2002:ac2:48b8:: with SMTP id u24mr1361429lfg.133.1573651072109;
 Wed, 13 Nov 2019 05:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20191113075335.31775-1-linus.walleij@linaro.org>
 <20191113075335.31775-2-linus.walleij@linaro.org> <CAPDyKFqx-0J0ck-hyeJsX8LrOP+BWiS6PihLd1Y3EMoXX+qYiQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqx-0J0ck-hyeJsX8LrOP+BWiS6PihLd1Y3EMoXX+qYiQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 14:17:40 +0100
Message-ID: <CACRpkdZhMjWyWQav1HhmfDkvUxOU8gGGbYJrd-tRXw8u+d2-Rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: mmci: Support odd block sizes for ux500v2 and
 qcom variant
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Russell King <linux@arm.linux.org.uk>,
        Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 13, 2019 at 12:06 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> > From: Ulf Hansson <ulf.hansson@linaro.org>
(...)
> There is no need to keep my authorship of the patch, it's very much
> different than the original. I would rather replace it that with a
> suggested-by tag.

OK

> This is too early in the series. You need to deal with the DMA and pio
> issues, before releasing this constraint.
>
> In other words, I would rather split this patch in two pieces. One
> patch dealing with dma submit error path, placed first in the series
> and another patch that adds the odd block sizes variant and releases
> the constraint, which should comes last.
>
> Makes sense?

Sure thing, I fix. We need to get the whole slew tested first then
I'll collect the Tested-by's and reorder and split.

Yours,
Linus Walleij
