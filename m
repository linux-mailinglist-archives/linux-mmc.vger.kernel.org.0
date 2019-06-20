Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DD14DC55
	for <lists+linux-mmc@lfdr.de>; Thu, 20 Jun 2019 23:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfFTVRG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 20 Jun 2019 17:17:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45419 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFTVRG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jun 2019 17:17:06 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so637492ioc.12
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2019 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWgtzmK5Dffhp4w0dM9JIEpJpXc3nwLUXojPORvneWU=;
        b=IjL3UQw6IiWddx8lu54V03rfMWEuut/voSjceIGDeCcMAi7rRstiXLjeq1Fzu1i/t7
         PCiN2rVxYN6WdaE4QuxkUCZeiRpPhT/zyV0k/ehEir/pe6W8bnf7ObJ/zkj6N2EPayT6
         vDCMOFScw+BqmympZrvhFKKoqL7MWkTq6Cqq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWgtzmK5Dffhp4w0dM9JIEpJpXc3nwLUXojPORvneWU=;
        b=tvTxwQH04t591Whg1ya7WQlzHKE7gw3CfWg5B+Uu353pBgZgiSIASbCaP7XQp66zEL
         5AN3pzJ//N3+4APQwyzbgCiC/CqP2fJ5VxJ2qJ18LwZ9fWzQoujV12G+zZnq5HwgSweF
         UyyyU2uVeoVCeq5tky5e5SQL8qrdr6DdQyU4iqiaRNe3XFKncy/JQpvHXqweD6xEYY3J
         7GLPi5Y53wC3r+x2xq5uLU5lO3puOFGNkIJ/9GbuAq6qjbgpMjTGQSs4sqLv503GfUJn
         jODPFwmmQxHV2vz0/gGKwlcRNxbQfQh1wMkKM45HAHLFmdMF0I1D4uW0ymEZRMj4QYLg
         rhxA==
X-Gm-Message-State: APjAAAWT++lt/zh4x6u5UqH+Cd6Xw1trAGu/GvKUT+zyvrkssi0dLGed
        qZc9htwEt5utlk/XbTKEVm6lTFrQ5ik=
X-Google-Smtp-Source: APXvYqwPthzAvmpy9Xk3Rw4/KzHpA5rne4lIrHRtEE2Znpgu0dj60dXVQZsCFltCGzbCzQbaTEalsw==
X-Received: by 2002:a02:84e6:: with SMTP id f93mr10238092jai.73.1561065425308;
        Thu, 20 Jun 2019 14:17:05 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id z26sm724218ioi.85.2019.06.20.14.17.04
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:17:04 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id e3so637379ioc.12
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2019 14:17:04 -0700 (PDT)
X-Received: by 2002:a02:5b05:: with SMTP id g5mr101301999jab.114.1561065423991;
 Thu, 20 Jun 2019 14:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190620152432.1408278-1-lkundrak@v3.sk> <CAPDyKFrSQR7+POv++8jW5VF4hTcQbNwZzqHntK1k4eNpy2gH=Q@mail.gmail.com>
In-Reply-To: <CAPDyKFrSQR7+POv++8jW5VF4hTcQbNwZzqHntK1k4eNpy2gH=Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Jun 2019 14:16:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBycK5hfa75e0vJ=9sjEG88TJyzU4--jsB6UyDe6nGVA@mail.gmail.com>
Message-ID: <CAD=FV=WBycK5hfa75e0vJ=9sjEG88TJyzU4--jsB6UyDe6nGVA@mail.gmail.com>
Subject: Re: [PATCH RESEND] mmc: core: try to use an id from the devicetree
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Jun 20, 2019 at 8:37 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Doug
>
> On Thu, 20 Jun 2019 at 17:24, Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > If there's a mmc* alias in the device tree, take the device number from
> > it, so that we end up with a device name that matches the alias.
>
> Lots of people would be happy if I queue something along the lines of
> what you propose. I am not really having any big problems with it, but
> I am reluctant to queue it because of other peoples quite strong
> opinions [1] that have been expressed in regards to this already.
>
> Kind regards
> Uffe
>
> [1]
> https://www.spinics.net/lists/devicetree-spec/msg00254.html

Yeah, I personally like being able to assign numbers too, but
unfortunately there are lots of people who objected.  BTW: if you
prefer the patchwork view of the same discussion that Ulf pointed to:

https://lore.kernel.org/patchwork/cover/674381/

As per that discussion, I think might be OK if we could find a way to
assign a string-based name to devices.  Then if your user manual calls
them "emmc", "sd", and "sdio" you could name them that way.  ...and if
your manual calls them "emmc", "sd0", "sd1" you could name them that
way.  ...but I wouldn't swear that people would actually truly like
that.

Given the total number of people who keep feeling like this is an
issue that needs to be solved, though, it does seem worthwhile for
someone to come up with a solution.


-Doug
