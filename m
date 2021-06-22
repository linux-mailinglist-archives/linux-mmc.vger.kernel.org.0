Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D343B0AB4
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Jun 2021 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhFVQ4c (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 22 Jun 2021 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFVQ4b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2021 12:56:31 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E0FC061760
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jun 2021 09:54:15 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id m15so3660335qvc.9
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jun 2021 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ln0rqCYelsyqtkFalmwSESWUlyrC6dhevN9AgMvP0es=;
        b=ZLQfwSSaECfOSlROL5O1FHfITEWnKqUE8cvB9T5PPjirTAOMnWmZdjsUCwl1g4kPPr
         XUPv7VEcFM2DmgpmjLKv4cmbNnZ/u/O0jZo4fu3vmcnnzDdkB8qyMAD8QUQsW3EriGRk
         ZuK+8EDXiwWgHqRMyWcUdrrzbS0u3BRBjDKaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ln0rqCYelsyqtkFalmwSESWUlyrC6dhevN9AgMvP0es=;
        b=Zf8BPPDOUbQMWV2JWIvuNhHUpN+GmYyh9LMRzbdtPbFaBoDR1Gcp1tiN/RB8xmUeN3
         cK0U+QhQ4XhlIRj4/NFL13yDyHZoQUVPb4+CRLCJcHbc8BrmVZqQmuDwiLTIvpysgPHU
         pbbKOxyfjr7b8c9g0eBPmO+sIf/QehuTSPfwQ7n0PSiyrtrMOgbk5Y3+Q2MAycTxbkW6
         cD8bu9rOKYUu5niuw6SBHO6ShWsoGeuUPFqfrsRV9kxDOvuJSalfN0v7dyl2Xgq2bK4k
         MFVVFFp6RHrK5wNruG6GhCN9THqgWrVRGaahfHBlAUQqzawF1uZ74j1PZVZJXUoICHPA
         Ydag==
X-Gm-Message-State: AOAM532uH3RSebQsfzVyyQ/M4P++kIy+Y+z2do/SZRIiz0vgpMX6NdoW
        VjT9Pu/o+ykbNcOJKE7wIZ5Smwmj3bRbLg==
X-Google-Smtp-Source: ABdhPJyPaqGY/MgXzcyiabKPSzbthd3uVnejG3gIa/iK0pPPY9N8TxBtQvwPoejeUIQam4lfuXxlww==
X-Received: by 2002:a0c:e802:: with SMTP id y2mr26161524qvn.2.1624380853699;
        Tue, 22 Jun 2021 09:54:13 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id t185sm2965025qkh.95.2021.06.22.09.54.12
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 09:54:13 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id c23so5728548qkc.10
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jun 2021 09:54:12 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr5864261ybk.405.1624380851918;
 Tue, 22 Jun 2021 09:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid> <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com>
In-Reply-To: <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jun 2021 09:53:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
Message-ID: <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Clark <robdclark@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        quic_c_gdjako@quicinc.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        linux-pci@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Rajat Jain <rajatja@google.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 21, 2021 at 7:05 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> On 6/22/21 7:52 AM, Douglas Anderson wrote:
> > @@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
> >
> >   static int iommu_group_alloc_default_domain(struct bus_type *bus,
> >                                           struct iommu_group *group,
> > -                                         unsigned int type)
> > +                                         unsigned int type,
> > +                                         struct device *dev)
> >   {
> >       struct iommu_domain *dom;
> >
> > @@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
> >       if (!dom)
> >               return -ENOMEM;
> >
> > +     /* Save the strictness requests from the device */
> > +     if (dev && type == IOMMU_DOMAIN_DMA) {
> > +             dom->request_non_strict = dev->request_non_strict_iommu;
> > +             dom->force_strict = dev->force_strict_iommu;
> > +     }
> > +
>
> An iommu default domain might be used by multiple devices which might
> have different "strict" attributions. Then who could override who?

My gut instinct would be that if multiple devices were part of a given
domain that it would be combined like this:

1. Any device that requests strict makes the domain strict force strict.

2. To request non-strict all of the devices in the domain would have
to request non-strict.

To do that I'd have to change my patchset obviously, but I don't think
it should be hard. We can just keep a count of devices and a count of
the strict vs. non-strict requests? If there are no other blockers
I'll try to do that in my v2.

-Doug
