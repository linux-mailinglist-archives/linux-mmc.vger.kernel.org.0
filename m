Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84C499302
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Aug 2019 14:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbfHVMNm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 08:13:42 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41798 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfHVMNh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2019 08:13:37 -0400
Received: by mail-ua1-f66.google.com with SMTP id 34so1904861uar.8
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2019 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mvo3obOpukOfhgTtLVmsxidJD3UDOJN2LjSEIs/pCEY=;
        b=yezPFauYmhYaA1IvJm9bJpL2dY24hl2CuZ23kSamOTyei7zmkpM9OwfeezL77smNmy
         brPejKcqSkGbdeG0TZhPjVTnbbSR+wUP/ef7qlhKjm1WrevaaTKdM1H5BJlulQSNFFBu
         ffPG25/rp7o/Np+uiVJ5mzu29geogy+OlShFowhzezrqK6jSKy2/ttts946z7KwBEK5H
         wnQkO/mNQJxlV1Z14pPtRBkgMBP1xn5E1R8TR3s9I8XCM+WYiRCE1b8xj+vvhDBM350a
         eawe58pkj08f/lPQkGSdVpLTGANBXb3hC9izuEQG64fH8ePiwIAUom1q0sA5Yp1ctCCV
         rMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mvo3obOpukOfhgTtLVmsxidJD3UDOJN2LjSEIs/pCEY=;
        b=im66kHVB6H+ZmgjvwCaBJSXgOzTfICZU4XzJMBbfnSxt16XOKrWIVS1B539LZwe7FY
         JZjsz16HzMvVgYjb+w4l7OXf7DB7Xb8R5HWtAa3O/HDerS9ZQsw41vzttOZoBhGLFIip
         D2x4CvbNYNgERU+brdVn8+RFHKFjsaSs5HuybNvQfnWgLs1zsOQGQaHLZFXhJ02qHadL
         JouikbwkRme/RqrrNu2h1VUb7FhnLfIKa7byvYPrq47vNGNlNGYdPqQmxfYU8uanDDCd
         //EtVXpeUIJypCm/A/aPzcw6ixCgJpJbIYwg6kvYrx0dyXP/d/pVI/hfhV5y1VVz4zy7
         38xg==
X-Gm-Message-State: APjAAAVxN6fKVjfpul7tUlI5q3GL7w77MF+lga2+6zRiwVMI0PIqbp3k
        7NiJKg0zMJyNrnjEf3grG1tzrXj6Rgcz20hQelSxjg==
X-Google-Smtp-Source: APXvYqw7ToGHxamlJhqcq3M4yWdo5/jCqSU8fUkV8Z6lMD/B9TiMtkFuCTmQqe2Zj1ICY4zk9zXEx7jisLrgFwz9Yzs=
X-Received: by 2002:ab0:1562:: with SMTP id p31mr5468313uae.15.1566476015930;
 Thu, 22 Aug 2019 05:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <CAPDyKFrUr8_VP1JLRk48zR8_p1Y62wKLBnS0iTgdhUSArwD49Q@mail.gmail.com> <20190809080842.zl4ytbjyt54bj6ta@M43218.corp.atmel.com>
In-Reply-To: <20190809080842.zl4ytbjyt54bj6ta@M43218.corp.atmel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 14:12:59 +0200
Message-ID: <CAPDyKFp_UdPqnOtqsOZcNxt+fTayMYm89_YLNH8J5-=VRcWTJA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
To:     Eugen.Hristev@microchip.com,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Aug 2019 at 10:09, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
>
> On Thu, Aug 08, 2019 at 05:23:00PM +0200, Ulf Hansson wrote:
> > On Thu, 8 Aug 2019 at 10:35, <Eugen.Hristev@microchip.com> wrote:
> > >
> > > From: Eugen Hristev <eugen.hristev@microchip.com>
> > >
> > > HS200 is not implemented in the driver, but the controller claims it
> > > through caps.
> > > Remove it via quirk.
> > > Without this quirk, the mmc core will try to enable hs200, which will fail,
> > > and the eMMC initialization will fail.
> > >
> > > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >
> > Should this be applied as a fix and possibly tagged for stable?
> >
> > In such case, do you have a specific commit that it fixes?
>
> I think so, I would say:
> Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
> Cc: stable@vger.kernel.org #v4.4 and later
>
> It doesn't apply on 4.4 but resolution is trivial.
>
> Regards
>
> Ludovic
>

[...]

Applied for fixes, by adding the above tags, thanks!

Kind regards
Uffe
