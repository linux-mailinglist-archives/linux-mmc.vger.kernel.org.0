Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2B33FF7
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 09:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFDHVS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 03:21:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40440 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFDHVR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 03:21:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id u11so18577649otq.7
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2019 00:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ij+iH+M/8ZGiIrnkdLwppmtGhbFWZZmZrQ33Tj+/Mrc=;
        b=yDQg+Hbw5mvBGb4xUoz1ag1VKA420B8yfXatcUYRBXoujf5xxVROodAkEMzm8vGAC8
         +5K8jcn4Ao8NvD4JFJ30tPa4FxPLtsvjTiDEc4A6xr1qls6+yHGTl34nS3GGXTRNMG1a
         QuLGgwjRM6Qz0d5ZSf4t9cRe5xrRzXB3PNGSy2KeYeNMwJp63r9fUy+g10j49J6JSvXU
         c9Zq14VEyHF4ckszQM1axPb9e/84ZtxZo00GDS7DPGq1MNkOklXhVUMs6jXt630id1xi
         tdmTAjKLSKqQCkw9nT+f/agp+b09xGNzMKcY1pXM7JoxiZDTXAbAf3QLH18CdX6IBmNm
         mWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ij+iH+M/8ZGiIrnkdLwppmtGhbFWZZmZrQ33Tj+/Mrc=;
        b=o3tZug/KIKfMLzLsZ9UwH8Qof4g8I3e5NH+FpKsSx/8Y5flicQENZpFQiaz+zz7YUg
         7F+OAYv03JCEzTvqtBHfX9BFN/Yiukiyft6KE23QYik0UlrG+XAC7o6kp4sHHtxHn19A
         2Edgd97LLvGmHUuvXhHmxu8zFzxc3QRGIN85OuGCkiOzR7CkPWnS7CUB+UGCqV2C3lsV
         u7P8ftPTVAbtAgwhLUetiVptIn4HOYLDWTPRZmQB+TPLLp+zsOiBsncuAphlXU7XLYZh
         bnj1IxP97K4DBcOPCHT2R9BUwvuDbFuxUPLECwc6qbPvN4Q02n1BiwnJDT2d+Jlzi8Ra
         +PPA==
X-Gm-Message-State: APjAAAVykBCYQNxcWd/JyaGYYlhJ22O785XXQMnkw9wokYXRFkkyl94B
        Lep+DKZJDKTbEOpvunjyvaXjtrv95WizPNSPHNlajA==
X-Google-Smtp-Source: APXvYqzBUAiuGQ5CCX7L+dnJzxsTgp2SrfkxqeAprdFIag5gSPpDu3rBRcC1fZzqHqLByA5H7ue4e092aXkMKuv1KJo=
X-Received: by 2002:a9d:10c:: with SMTP id 12mr4258825otu.123.1559632877063;
 Tue, 04 Jun 2019 00:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558346019.git.baolin.wang@linaro.org> <CAMz4ku+E=kFgWrvm_wzM2XQQUyYZhc5uokcGEAEbEKpNAYZQ7g@mail.gmail.com>
 <CAPDyKFoZmxmRYwL_m60=DK9J5+beshEsLw5D=FySzRfYFdsb3Q@mail.gmail.com>
In-Reply-To: <CAPDyKFoZmxmRYwL_m60=DK9J5+beshEsLw5D=FySzRfYFdsb3Q@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 4 Jun 2019 15:21:04 +0800
Message-ID: <CAMz4ku+7W7LOxr_+utuN5-B8z=xGkrgdVWnmeNJrnFb_VWfF6w@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add SD host controller support for SC9860 platform
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Jun 2019 at 15:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 3 Jun 2019 at 10:42, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > Hi Adrian & Ulf,
> >
> > On Mon, 20 May 2019 at 18:12, Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > This patch set adds optional clock support, HS400 enhanced strobe mode support,
> > > PHY DLL configuration and other optimization to make the SD host controller
> > > can work well on the Spreadtrum SC9860 platform.
> >
> > Do you have any comments for this patch set? Thanks.
> >
>
> Seems like the series is almost ready to go. However, due to a few the
> minor comments/questions from Adrian, I am expecting a new version
> from you before applying.

Okay, I am preparing the V2 with addressing the minor comment. Thanks.

-- 
Baolin Wang
Best Regards
