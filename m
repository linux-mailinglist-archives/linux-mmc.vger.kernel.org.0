Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E596DDF0F9
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Oct 2019 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJUPNM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Oct 2019 11:13:12 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41689 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUPNM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2019 11:13:12 -0400
Received: by mail-vs1-f68.google.com with SMTP id l2so9089050vsr.8
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l00m7i2g3h4sFL0Iz9ZtMToycl29HM6ENN8hVPE+L40=;
        b=ZZqwlbgYx1rOKTMM9TnPAVIz2uZ5iLe1hk9/63PNIRVXTWLaWWQJZZq/8/NbfYKSYS
         8qr60wAbDxcFtDBtBNnFaSThY5kjxmU5Aoapqj27zU+4TthbccRUOdY7RcD4oxg1Vv3r
         1gTR3TutrIkMldp2sGCaDRU/QtEzhPf0vxkzCWcz50AuaGrGpj4sgiLimiHvrgF4qjpy
         wKk6llqtbPIy72fzk/jRdms+VUDCGppxQFPIkIcH9yURBokUdXEVMIo4wRT+842Jc9Ek
         IYM0gQteAXqmSOngrKBxodivEY6z34Ufnu1Dp4wvevsdHwMYy7bLF3+BnimyPyhyCSSu
         DQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l00m7i2g3h4sFL0Iz9ZtMToycl29HM6ENN8hVPE+L40=;
        b=t0WubI+g4c79OawB5AlDS1mYz+J5iI+J2HxwiPjaVURsH8jWmsjqRlenOIJJZRMAHX
         tziacrX95t87PXXwbd72jn6Eu+F4Il++8jrPFCka2KA6Je10PTcbo99r0fZLNAKY0BqL
         gt7Q8EiL+7LnoKihAikaht0/DvreKySTLrC/r3Coh9n7YZK2D79j/YtKjyrtNCZbSKQH
         uYItha1s722hh8of7yfqYSnKCbuwlsbRt3uGmoC2e8o1CHyT90fzEO4xbtA9d6C93/Yw
         YD8e3Uupg1GSkOWafLNU5HBD/AW733LNs4Oe+U5q/m6FfmOK4RQz5EE9G7QUAl7oDWZW
         3nBA==
X-Gm-Message-State: APjAAAWke7nNTn+8UWqwzNtHb4C1ofhBIk5PZCdrinWoYAbf7mfEFr71
        ETTb+XitOL/mvh1lDYnrj7PF07knKcthF9IFz4EVleys
X-Google-Smtp-Source: APXvYqwD6hVdXz8ZHq+vaI8FotZi8/NPEwHEd7C0LEntTPzaeZPhoG6c9shoxwvg/UF8lHl8FIyOlXFmW+V4b7Xw6V8=
X-Received: by 2002:a67:cf05:: with SMTP id y5mr14077790vsl.34.1571670791235;
 Mon, 21 Oct 2019 08:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAJPHfYNiibuOnQb_oJPVfB7rDiOqO1widt8wkTU4oQ1fJ6NwMQ@mail.gmail.com>
In-Reply-To: <CAJPHfYNiibuOnQb_oJPVfB7rDiOqO1widt8wkTU4oQ1fJ6NwMQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Oct 2019 17:12:34 +0200
Message-ID: <CAPDyKFodHpYgpHdBZ=09GK+WjamQ-6YETQr-Z0BtH5JH63S+Rg@mail.gmail.com>
Subject: Re: MMC life-time register, why not updated very time when reading
 the attribute in /sys
To:     Yi Zheng <goodmenzy@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jungseung Lee <js07.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Oct 2019 at 10:21, Yi Zheng <goodmenzy@gmail.com> wrote:
>
> Hi, all,
>
>   In the commit v4.10-rc8-9-g46bc5c408e4e, Jungseung Lee introduced an easy
> way to access the EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A/B registers.
>
>   That is fine, it avoid to parse the ECSD raw data from the debugfs mnt point:
>  /sys/kernel/debug/mmc0/mmc0:0001/ext_csd.
>
> But the code seems that only read the ECSD when init the Card. On our machines
> with BGA chip, run in long time, that sysfs attr seems not updated. It
> only keeps the
> original values when booting/init.
>
> Any plan to update that ?

Well, the current approach is as you say, a snapshot taken at card
initialization.

The life time time bits is not the only bits that may get updated over
time, so it seems we need to re-read the EXT_CSD to get the latest
data. At least for some of the bits in the EXT_CSD.

If you or someone else sends a patch, I would not have a problem accepting that.

Kind regards
Uffe
