Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED0AB7FC
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 14:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389695AbfIFMTU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Sep 2019 08:19:20 -0400
Received: from mail-vk1-f177.google.com ([209.85.221.177]:36581 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732863AbfIFMTU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Sep 2019 08:19:20 -0400
Received: by mail-vk1-f177.google.com with SMTP id b25so1225930vkk.3
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2019 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xaDeWIcc/vXABDR4eSFpAVfvx8oH8RV1G7CfDYMxo8Q=;
        b=eBk9ozGr2KOByDllbFbnEgmXG1ntdX5XeKutO0xWf16Qybhkt2Rf5AXmtjWziJmPTs
         KhWJV2g3CE/eymU0ZNuEppIiLGeKPkrm5v/28GGLUi1pEEdgrRynR221uugPstcD0Ipu
         lcqOCBlhaxDxNXIXO+VuA7RXPU2zMPrC0R8jrdhtKTEjiL+hXj4f0d5DeGcNyIzKHmdb
         /KRCqJeWQhgLUaSBhKwU78pCsazmH1c3Wwl927B2QlGkKNK9vQzH6yhre19W2I5HQz6a
         KLNMXzay0oUEUbCVpZB4kvNr+YlZq8BNtsQTuMW9J64e84wl975wmWGMCPSYo9wgX881
         g7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xaDeWIcc/vXABDR4eSFpAVfvx8oH8RV1G7CfDYMxo8Q=;
        b=eyLlWO4f7p8RxvMWvEfByNmFgdaqmqPieIeTZ5y8aP/lRPfA2fVTiEzk9fFqqS4OBF
         Yt7hESJ1d5SazUabL95JncEZzLTiWMuhDGs+BozoziYvsDmwFJBuFLJ1evtaQ8ic58hO
         VKsh+fYZ/KknpqVhDNu1nvfJc/9lwC4AHL/Eo+K/C1q/9/KU7+huKYKTd0jCxtlb5JWO
         Gz7irckzZ38aqp2baFHPY518QoduX6KHNhFEJYo/y0RVMMcY9M+iiE7r9tZjNwUvxAhI
         sbzxVqEiAvZeSCs7xR0PjlNy4NQbVlV40af9AbLJYHrdp+u2iYZdQ5kRxkq/SDLORI+u
         108A==
X-Gm-Message-State: APjAAAUhtYPwQzOuCY0V+mA7rJK55HToKNqfYR8x4dD7aNfF/G3JVZ5Y
        tu24kXZG0g6596uPuxWU4CvGFbyDkyjLVDbHd8O1agSj
X-Google-Smtp-Source: APXvYqyolBR/Nzwx2kZYHguX+XJcJHLgvCQTcBp3a9AbEGW+0jG8nsKoYk+NYxJmdqbJYjL2te71YleQBnp4YUOabS8=
X-Received: by 2002:a1f:8fc4:: with SMTP id r187mr4114134vkd.17.1567772359627;
 Fri, 06 Sep 2019 05:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv37SXnNz07a4tKkLiY9CtD72YjBJmKhHcQq=QiM2608-fA@mail.gmail.com>
In-Reply-To: <CAAfyv37SXnNz07a4tKkLiY9CtD72YjBJmKhHcQq=QiM2608-fA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Sep 2019 14:18:43 +0200
Message-ID: <CAPDyKFo5E3a0w6YKReMNrU_Z1td6jTbgKH-d+shOynhyPsGGHA@mail.gmail.com>
Subject: Re: slow emmc speed 4.12 am437x
To:     Belisko Marek <marek.belisko@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Sep 2019 at 11:14, Belisko Marek <marek.belisko@gmail.com> wrote:
>
> Hi,
>
> I'm trying to get some insights about how to debug emmc speed issue.
> We're using board with am437x CPU using mainline 4.12 kernel (added
> only devicetree for our custom board). eMMC is 8bit connect (using
> sandisk SDINBDG4-8G-I1 chip).
>
> Issue is that when copying data from SD card to eMMC we get throughput
> only ~300kB/s (it should be bit higher IIRC). I'm just looking for
> some advice what to check and how to find out where issue can be
> (still unsure if SW or HW). Thanks a lot.

Mount debugfs and look at the ios node for the mmc host in question.
There is information about clocks, busdwidth, etc.

Kind regards
Uffe
