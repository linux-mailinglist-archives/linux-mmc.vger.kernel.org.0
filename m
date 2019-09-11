Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4753EAFC2F
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Sep 2019 14:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfIKMHO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Sep 2019 08:07:14 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38035 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfIKMHO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Sep 2019 08:07:14 -0400
Received: by mail-ua1-f65.google.com with SMTP id 107so6691781uau.5
        for <linux-mmc@vger.kernel.org>; Wed, 11 Sep 2019 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/W60zi2CsnYN3oTG7y8mYKQVQdd1OgZCvvKaWEAFp1Q=;
        b=GLqOvUYQJXCW5SvJ4CneXBkrDEz8pJWYKS2UiBssfPdaLACxSvkuI5OvIYJGEYjjqE
         cUKV2A5GorrESRFbUXruLYcRkLE7zysW9cB3DKRhYleYX7lfuaMEjH9ms1pLUXgUk/ga
         AtWSvRuI1lRk+Iyz2TkD0lPx4g07tYYl9X6G+AbpiumYRog0O1rzm9VT33DP6Z0kmYz4
         vMab7Wfv8VvJLhGFAuKqmODy0KH7+8olA6iIsgLC1GJ6h8cJPzFzFViLd+rFxMCRubVv
         LANBylL1rUTIy8ZgvuoDO/kgM8B8H6Ikxqa9IyMKv8xIbSQAegJmuPU/eZzMsC08oh/h
         6piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/W60zi2CsnYN3oTG7y8mYKQVQdd1OgZCvvKaWEAFp1Q=;
        b=hKFnTi6Lzi1mA1HToJRuBmg8Tj85hJROzX1mUiMdkf4z08umCoMNdU2nEAiJaqfgYQ
         MopiusWpYtrgPpcLKQWpEYjlCYVHmFCt7F8tx5IVSrdmFXZ5ptSHh+2cm43GwQuMTb/b
         5ql/HNtGHt8qQn4roy9RFzOtySF3a6AK9n76ORRJZpmpr36DmIDfhslT338ggJ3SMwBX
         quIiy7jOzZs532E9Qo84SuyZJfQPuOqwm+3HD97omuuRzxHt64lzVhbk3gdXjE0DeT6V
         sfxeBODI5AtqBU7O+mF4Ot4FqSOgOVjOfITa212FaXbZxdkHXXd5BbWuns/Z1Myh+Am4
         vNqw==
X-Gm-Message-State: APjAAAVBRJ3nM2+gxgqx56feDqD0ia1tjiYK4MAtMGkl/+/ZS1g0/P9v
        ZUMpLotRZlxSbUnsNFbz5+qWCbFUzWPbbC4jh+JMaQ==
X-Google-Smtp-Source: APXvYqyHwlzHmgm/F3rLCurrnWpPOQ6N0VtapKXg6cMw0YxI7Dd9PBI/rZrdtfNNpy0PoR1fPnLL/GpHB6Hiw8NQA7E=
X-Received: by 2002:ab0:3113:: with SMTP id e19mr2059643ual.129.1568203631219;
 Wed, 11 Sep 2019 05:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-4-ulf.hansson@linaro.org>
 <CAD=FV=U=ohP9KFWrMYfdbT4WbOxGXFNMd71c7ej1G9Qrtim=7w@mail.gmail.com>
In-Reply-To: <CAD=FV=U=ohP9KFWrMYfdbT4WbOxGXFNMd71c7ej1G9Qrtim=7w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Sep 2019 14:06:35 +0200
Message-ID: <CAPDyKFpaM5Os_B_f=b5aY87Espm6GvGG=C6sRemzvfG=9rE74A@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Sep 2019 at 00:29, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> > the driver. However, this still means msdc_runtime_suspend|resume() gets
> > called during system suspend/resume, via pm_runtime_force_suspend|resume().
> >
> > This means during system suspend/resume, the register context of the mtk-sd
> > device most likely loses its register context, even in cases when SDIO IRQs
> > have been enabled.
> >
> > To re-enable the SDIO IRQs during system resume, the mtk-sd driver
> > currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> > the SDIO card, but this isn't the recommended solution. Instead, it's
> > better to deal with this locally in the mtk-sd driver, so let's do that.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 6946bb040a28..ae7688098b7b 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -2408,6 +2408,9 @@ static void msdc_save_reg(struct msdc_host *host)
> >         } else {
> >                 host->save_para.pad_tune = readl(host->base + tune_reg);
> >         }
> > +
> > +       if (sdio_irq_claimed(host->mmc))
> > +               __msdc_enable_sdio_irq(host, 1);
> >  }
> >
> >  static void msdc_restore_reg(struct msdc_host *host)
>
> I don't personally have a Mediatek device setup to test this patch on.
> If it's super urgent I could try to track down one and try to set it
> up, but hopefully it's easier for someone else...
>
> That being said, from code inspection it seems like you should be
> adding your code to msdc_restore_reg(), not to msdc_save_reg().  Am I
> confused?

No, you are absolutely correct, my bad. Thanks a lot for spotting this!

Kind regards
Uffe
