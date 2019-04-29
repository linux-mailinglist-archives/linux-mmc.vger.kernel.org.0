Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772D6EAAA
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 21:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfD2TMt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 15:12:49 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:39220 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2TMt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 15:12:49 -0400
Received: by mail-pf1-f174.google.com with SMTP id z26so1915882pfg.6
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2019 12:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=I+Vwh+aj8i01Aoc1va0F0AKmwtckh5pIZyNVc/ubEjA=;
        b=VaHFRdDRj6eJOVFiKIr/NRI/A3CmYY51cWuDmljwcipcSkk9RAX15gqcfXiWrJl1Ru
         emAWKKzrlBq+t8cdY6lOPlvKuq3yhDe7dKqtfcJXJG3iys7N7On6QtchJm/gBaigOn8E
         LwY2bdmB7p7Nn3i8xS6ycyXdP/LyEzqyT573AQBm8ONdienOep0ZnsZ6S9qc254wr4f3
         hH0QJ0QYBrYth5M5Q88XC/GrGyd00QjVFh23+P0Fgz/vKAItIGfNfvMtAaiz6J3MFlNT
         QVJhZklgjYiuw1U3U7svnW9w97PB6OBuF77wY8gVWDYpM8mv02iXSi3cLzlhH22xbnC0
         x7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I+Vwh+aj8i01Aoc1va0F0AKmwtckh5pIZyNVc/ubEjA=;
        b=rQ5/oTRL6I11THU3MhYwki6L0ZOgf5GMxMmdQcOfE/71z/vaTENeELx05mH+oYFT0F
         20kIg71HepVKf/XioxHGyBUTo81eNG46hXJ5WbYZYF9wD1hbBWvXoo7F/6Ux2xxIEG9y
         dKi3VQDrRPDbNZk8r9zsOl8NFtNwlV0fEZ09/10uy89uRLMCvLmdvTEHDZaoaZjQ5OC3
         GEepwOdVhinso0sN0KZhrEHLxQvos6mNOqR0C4h29YOHLDJdAPMoxTehJ0Kvh3k9AFal
         W98TskEo8WidOu5mAsemWJC4SYfb/VEDi/jNXXvf7LNTKBGTNC8tdW3Wm2rkHhGxZMDB
         b7qQ==
X-Gm-Message-State: APjAAAW5Jw2H3wOvTlAq1t8/fZ5EsUa7tKByDgR2MhC8nnHR+QcD8D4V
        /BkNK/85y2vcj9SIzwKR6Al6bA==
X-Google-Smtp-Source: APXvYqwfpP13ENa3/d3PDzljfX3CD44ZmLJDWwRIZ1vdZggbfqA1LXOkJGHBQJhUusCrVAuzyQhPGw==
X-Received: by 2002:a63:8242:: with SMTP id w63mr12207839pgd.169.1556565168285;
        Mon, 29 Apr 2019 12:12:48 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:f580:39a4:9be7:1974])
        by smtp.googlemail.com with ESMTPSA id q128sm51546066pga.60.2019.04.29.12.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 12:12:46 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
In-Reply-To: <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com> <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com> <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
Date:   Mon, 29 Apr 2019 12:12:46 -0700
Message-ID: <7hwojcr5g1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Ulf, Hi Kevin,
>
> On Mon, Apr 29, 2019 at 12:45 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Tue, 23 Apr 2019 at 11:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
>> >
>> > The purpose of this series is too improve reliability of the amlogic mmc
>> > driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)
>> >
>> > * The 3 first patches are just harmless clean ups.
>>
>> Applied these first three, postponing the the rest until Martin are
>> happy with all of them. Thanks!
> thank you for taking the first three patches!
> I am fine with everything except the patch description of patch 4 and
> 7 as noted here: [0]
>
> Kevin, can you please also have a look at this series (if you didn't already)?
> you reviewed earlier changes to the tuning mechanism in this driver.
> it would be great to know that you're happy with these changes as well.

I've reviewed the series, and am happy with it as is, including the
changelogs as is.

Ulf, for the series, feel free to add:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
