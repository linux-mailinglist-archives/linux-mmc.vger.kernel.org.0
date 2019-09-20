Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79492B8BBF
	for <lists+linux-mmc@lfdr.de>; Fri, 20 Sep 2019 09:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437586AbfITHrp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 20 Sep 2019 03:47:45 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45233 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437579AbfITHrp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Sep 2019 03:47:45 -0400
Received: by mail-ua1-f65.google.com with SMTP id j5so1916047uak.12
        for <linux-mmc@vger.kernel.org>; Fri, 20 Sep 2019 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxglbnyqNsy9IrMeX1phK/aGWuTchg+w3X2HNfK/9CM=;
        b=mRkPMjzvPBVfAeCHVbJTYmrEh8uq38ZKVM8E8AFU6NzBMCkin/nd1eIBhx73UcvIPj
         hZ9cLZl7VRnRHz0r9b+vw/tUY5l1L8pgCBGOVyccwzB3loxNIAfhw8f57iYt1IVFHmMG
         3ihqT7adb8ixIuRyXLY28hq5ZvJnUjZr99BB8J0MuUtrXiFlrJAhlWPEp5EDSLnkwd6j
         gjJUOVRjbfeyDNz7/rz7jmEHiaLot6qL149wtDhUGZaREGUjVZZCucZTaTlcf93XPL/+
         tkpHNvmoPXhsNOFXcMyryFbNn/lRqf4ubcSr7Nk6ZF/pyAtrNhtGObkvcyf+0/vSpDDJ
         xc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxglbnyqNsy9IrMeX1phK/aGWuTchg+w3X2HNfK/9CM=;
        b=eCJtmBm43R668Bt4GOyMrVF35r2H4p58GBpzIAHhrVcrvdK2mAJE0tRJFqzb5MmyTe
         gSiMSyN2O8vp6/HAR9vwScT7I9RMo0UqGMrAF/QqmYY1RCgv1mbbv/fBSXg1lHheFZWm
         S3ZABuoAlmHZS5bDfZ0J6eNekGoI2bpFH7O9VdHnurg/NQxCpy/oDBoZGEqBH6ECktxU
         /wBHq5rmGZVazvpuS9IguXxlredtPeJ/3bbXIYLUzyy5nbWAg6tAlXVTK8FOrBjiIesJ
         vxfepJy1DaBnD0Zf9ZPpqfN7+f2LGTy9Znga6JoMePWCf+igQIj36bXMxax4tXydF9u5
         ttgw==
X-Gm-Message-State: APjAAAVA6ZJkMlhJEb9EAo1LcLXnr6n0+2KncnYzZaSr1WmTBS2mbuQ0
        YpugKqp4VtgX9mzbKNrHJ5aZLnKLD7+49hV0ObDPew==
X-Google-Smtp-Source: APXvYqyIPD8otiC6oiySJICKUArdhKAFf1jxKg7NkboCvLV7vKR9MnpHuTM4AuE9NqL9JQuhAM9Efy4otC84oobLXJw=
X-Received: by 2002:ab0:1856:: with SMTP id j22mr8516177uag.19.1568965664676;
 Fri, 20 Sep 2019 00:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190905122112.29672-1-ludovic.Barre@st.com> <940e3ce8-1a4f-7e03-dfec-25330051ea5f@st.com>
In-Reply-To: <940e3ce8-1a4f-7e03-dfec-25330051ea5f@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Sep 2019 09:47:07 +0200
Message-ID: <CAPDyKFoha6q1CmhLXREz8OAzd4UiBDKpHo46J1PLGMkf8CStpg@mail.gmail.com>
Subject: Re: [PATCH V6 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Sep 2019 at 11:33, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Just a "gentleman ping" about this series and
> https://lkml.org/lkml/2019/9/4/747

Thanks for pinging, I will come to this as soon as I can. September
has been a busy month, being on the road most of the time.

Apologize for the delays!

[...]

Kind regards
Uffe
