Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19E670F21
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 04:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfGWCXF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 22:23:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35957 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfGWCXF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 22:23:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so41433512wrs.3
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 19:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smIBfaqRu5nVbUNVJ3QpFMy6Z601i9cV+gQ3DY7R5k4=;
        b=YcbYoAU09XE5B1Rm0YYEu60Cx0yX3kP+4xSWuSBG1O/DSZ/G0bo4OV8UiBlhuUE10Q
         AYKVhjCMR4uKfARwtoxw9780J9FUcoovEZGusEqG+b4vmtJq6d0ghOeCj42IgOJByNJ9
         EbV80KS6GdDzMNkAosaVBc69ZtpEST+jmkysVeUacj75i6zZeAorTJva1WNqYd3S4h1L
         uCSelQ1lQRsSGzBnWMkYIkqHpt7TlY2cU2lKlux5LEEWt8W99VPHwTdFpF6VdI1XVf8D
         e5ljTBajERGLiNYvxiWY86K9sot0WDxb7wo7ehOcOtZLJ0++Y9fI92YVeR+WbwVLIMcD
         r1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smIBfaqRu5nVbUNVJ3QpFMy6Z601i9cV+gQ3DY7R5k4=;
        b=KZiXMCRI4UHAedqgbezUzh61SJw+ALT75XzGNavWt5edpNv9TRxQ92WBIOAAQKzVcm
         7oQI197U1MJ6Lp+ubQqjawwInIjyeao/wnZGjH/Prm4B8FFAdVh/b1vhmiADcP1MS/V2
         sqib5GcN01mtnSx/4ZeArU9f0q3ePjNOa6qNWgBUwEKZrStVsNI4FJx8wtRdVD/Nt2Y3
         8H3IA5+Tior9npD11iRr+ciaaACoWUmhFlEkkaGpt/hzWYJQ1CMpzKLjtykLFpQiyhPH
         y15L4URB7FwDoQu0vn8W0mQTVEyt4FQF5p4s9hAJZxiHXp97xMk5tc8omuUrxTjf/y76
         bUVg==
X-Gm-Message-State: APjAAAUeeONrLMRfaxh4yaEebbDepHX0HyQX7Ffg/v+wsXlZP2Ytfy/A
        B1OcNymiAQdo+IKxtMHAXqbtKKqV/uIvlMJJYiIy1w==
X-Google-Smtp-Source: APXvYqxg9tXO/TzVX41mugstVl1oRKlKbYg3q4zGZMPblfkEg5gQB2oOTHkQozlvS1lM38OB7JYe547iRi055koc48U=
X-Received: by 2002:a5d:4111:: with SMTP id l17mr77854358wrp.59.1563848583619;
 Mon, 22 Jul 2019 19:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <1563768186-22161-1-git-send-email-shihpo.hung@sifive.com> <CAPDyKFoUTHZt6LNgUiiLnqXgABSg4mZYdvWTE9VPJ5LWHwTbGg@mail.gmail.com>
In-Reply-To: <CAPDyKFoUTHZt6LNgUiiLnqXgABSg4mZYdvWTE9VPJ5LWHwTbGg@mail.gmail.com>
From:   ShihPo Hung <shihpo.hung@sifive.com>
Date:   Tue, 23 Jul 2019 10:22:50 +0800
Message-ID: <CALoQrwfEerTveHhgpLw+qLL=nHCSh8epp6-FdOLh9h-POOr9eg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_spi: Enable stable writes
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andreas Koop <andreas.koop@zf.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jul 22, 2019 at 9:43 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Wow, that was an old bug that needed to be fixed! Thanks for re-posting!
>
> I have applied this for fixes and by adding a stable tag! I also
> decided to keep Andreas as the author as it seems like the code is
> very similar to its original. I also cleanup up the changelog, but
> just a little bit.
>
> Kind regards
> Uffe

Great, thanks!

ShihPo
